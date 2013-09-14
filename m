From: preeti@linux.vnet.ibm.com (Preeti U Murthy)
Date: Sat, 14 Sep 2013 05:53:10 +0530
Subject: [PATCH 1/2] tick: broadcast: Deny per-cpu clockevents from being
 broadcast sources
In-Reply-To: <2a29ccc9-6aea-47ca-9306-4f17d7cc2fe4@DB9EHSMHS013.ehs.local>
References: <1379004640-15117-1-git-send-email-soren.brinkmann@xilinx.com>
 <1379004640-15117-2-git-send-email-soren.brinkmann@xilinx.com>
 <alpine.DEB.2.02.1309122224420.4089@ionos.tec.linutronix.de>
 <5232CC15.8090208@linaro.org>
 <CAM4v1pPQwBfQ3V6M2VGsc-Fh+VhLkQE2JZeoVc=_3kniODNEhA@mail.gmail.com>
 <5232EB72.9050904@linux.vnet.ibm.com>
 <2a29ccc9-6aea-47ca-9306-4f17d7cc2fe4@DB9EHSMHS013.ehs.local>
Message-ID: <5233AC6E.1040002@linux.vnet.ibm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Soren,

On 09/13/2013 09:53 PM, S?ren Brinkmann wrote:
> Hi Preeti,
> Thanks for the explanation but now I'm a little confused. That's a lot of
> details and I'm lacking the in depth knowledge to fully understand
> everything.
> 
> Is it correct to say, that your patch series enables per cpu devices to
> be the broadcast device - for PPC?

Not really. We have a pseudo clock device, which is registered as the
broadcast device. This clock device has all the features of an external
clock device that the broadcast framework expects from a broadcast
device like !CLOCK_FEAT_C3STOP & !FEAT_PERCPU that you introduce in your
patch.

It as though we trick the broadcast framework into believing that we
have an external device, while in reality the pseudo device is just a dummy.

So if this is a pseudo device, which gets registered as the broadcast
device, how do we program it to handle broadcast events? That is where
the per cpu device steps in. It serves as the clock source to this
pseudo device. Meaning we program the per cpu device for the next
broadcast event using a hrtimer framework that we introduce, which calls
pseudo_dev->event_handler on expiry. This is nothing but the broadcast
handler.

Therefore we are able to manage broadcast without having to have an
explicit clock device for the purpose.

> And that would mean, that even though you have a per cpu device, you'd
> deliberately not set the FEAT_PERCPU flag, because on PPC a per cpu
> timer is a valid broadcast device?

No we would set the FEAT_PERCPU for the per cpu device on PPC. As I
mentioned above this is not going to be registered as the broadcast
device. We would however not set this flag for the pseudo device, that
we register as the broadcast device.

> 
> Assuming that is not going into an utterly wrong direction: How would we
> close on this one? AFAIK, ARM does not have this capability and I guess
> it won't be added. So, should I go forward with the fix proposed by
> Thomas? Should we rename the FEAT_PERCPU flag to something else, given
> that PPC may use per cpu devices for broadcasting and the sole usage of
> that flag is to prevent such a device from becoming the broadcast device?

You can go ahead with this fix because as explained above, when we
register a broadcast device we use a pseudo device which has the
features that the broadcast framework approves. The per cpu device does
not register itself with the broadcast framework. It merely programs
itself for the next broadcast event. Hence this fix will not hinder the
broadcast support on PPC.
> 
> 	Thanks,
> 	S?ren
> 
> 
Regards
Preeti U Murthy
