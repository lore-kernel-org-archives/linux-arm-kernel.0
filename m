From: briannorris@chromium.org (Brian Norris)
Date: Thu, 27 Aug 2015 13:56:05 -0700
Subject: [PATCH 2/2] ARM: dts: rockchip: correct regulator PM properties
In-Reply-To: <2079050.z559I6SEaj@phil>
References: <1439923455-109818-1-git-send-email-briannorris@chromium.org>
 <10828643.SSUS2EOuvv@phil>
 <CAD=FV=UiCcqCm+W4=ExOps8Npi=mkdVgJ2zgdomOw3YqPhCqug@mail.gmail.com>
 <2079050.z559I6SEaj@phil>
Message-ID: <20150827205605.GA42154@google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 27, 2015 at 10:51:22PM +0200, Heiko Stuebner wrote:
> Am Donnerstag, 27. August 2015, 12:30:51 schrieb Doug Anderson:
> > If I understand correctly, the distinction between "standby" and "mem"
> > is not too clearly defined, so if we wanted to use it for this it
> > wouldn't be terrible?

I never understood many clear definitions here either, personally.

> From reading Documentation/power/states.txt it looks like the boot-cpu is 
> supposed to retain power in the suspend state. Although we also do not lose 
> "operating state" in our suspend I guess?
> 
> So using the shallow suspend as standby sounds interesting, for the time when 
> the deep suspend works too. If there is only one suspend state it 
> automatically becomes the "mem"-state it seems.

It's not really "automatic", it's a product of this line:

static const struct platform_suspend_ops rk3288_suspend_ops = {
        .enter   = rk3288_suspend_enter,
        .valid   = suspend_valid_only_mem,  <--- here
        .prepare = rk3288_suspend_prepare,
        .finish  = rk3288_suspend_finish,
};

and the fact that we don't check the 'state' argument in
.enter/.prepare/.finish.

But still, I'm not sure it's productive to rename shallow until we support
deep.

Regards,
Brian
