From: ming.lei@canonical.com (Ming Lei)
Date: Sun, 28 Aug 2011 00:57:16 +0800
Subject: [PATCH] usb: ehci: fix update qtd->token in qh_append_tds
In-Reply-To: <20110827160746.GA11076@kroah.com>
References: <1314456515-16419-1-git-send-email-ming.lei@canonical.com>
	<20110827151317.GA10013@kroah.com>
	<CACVXFVM_p_XPyOOgz7kbEo93SCCxPa4X_vjYGm+fUGMPSFM4EA@mail.gmail.com>
	<20110827160746.GA11076@kroah.com>
Message-ID: <CACVXFVNz_ic_PPM_vNn1Dz85A2z94kRFso4rcqrvJfuLSqRSCg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Thanks for your comment.

On Sun, Aug 28, 2011 at 12:07 AM, Greg KH <greg@kroah.com> wrote:

>> As Santosh pointed out, mb on ARM will flush L2 write buffer. The
>> description here is wrong.
>
> Then this can't be accepted as-is :)

Yes, I will update it in v1, :-)

>> I think the below should make the writing reach into memory on all
>> ARCH after ' token = dummy->hw_token;' is executed.
>>
>> ? ? ? ? ? ? ? ? ? ? ? ?dummy->hw_token = token;
>> ? ? ? ? ? ? ? ? ? ? ? ?mb()
>> ? ? ? ? ? ? ? ? ? ? ? ?token = dummy->hw_token;
>>
>> The above is the idea introduced to fix the problem.
>
> Are you sure? ?Have you read the documentation about memory barriers to
> confirm this?

I read the doc again, :-), and it mentions few about mb/wmb/rmb, I think
my above description is still not correct. Generally speaking, mb only
means there is a order between two accesses.

Now I think only one mb() after 'dummy->hw_token = token;' is enough:
HC will read the up-to-date value of qtd->hw_token after mb() is executed
because of the effect of the mb(), which should be guaranteed by mb.

> I mean others, please read the the last 3 lines of the comment and
> compare that to the code lines you added.

I see now, the comment of the last 3 lines is wrong, should be

                        * inside L2 cache. 'token = dummy->hw_token'
                         * after mb() is added for obeying correct mb()
                         * usage.

But the 'token = dummy->hw_token' after mb() isn't needed any
more as described above,  is it?


thanks,
--
Ming Lei
