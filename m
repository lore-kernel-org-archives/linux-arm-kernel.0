From: Dave.Martin@arm.com (Dave Martin)
Date: Mon, 23 Mar 2015 16:28:14 +0000
Subject: [RFC PATCH 1/7] serial: Emulate break using control characters
In-Reply-To: <55103125.7080500@linaro.org>
References: <1426688428-3150-1-git-send-email-daniel.thompson@linaro.org>
 <1426688428-3150-2-git-send-email-daniel.thompson@linaro.org>
 <20150320142847.GB4725@e103592.cambridge.arm.com>
 <55103125.7080500@linaro.org>
Message-ID: <20150323162805.GA3579@e103592.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Mar 23, 2015 at 03:28:37PM +0000, Daniel Thompson wrote:
> On 20/03/15 14:28, Dave Martin wrote:
> >On Wed, Mar 18, 2015 at 02:20:22PM +0000, Daniel Thompson wrote:
> >>Currently the magic SysRq functions can accessed by sending a break on
> >>the serial port. Unfortunately some networked serial proxies make it
> >>difficult to send a break meaning SysRq functions cannot be used. This
> >>patch provides a workaround by allowing the (fairly unlikely) sequence
> >>of ^B^R^K characters to emulate a real break.
> >
> >This is neat, but as it stands it feels like a bit of a hack.  It would
> >be preferable to make the magic string configurable, since almost any
> >choice is going to upset somebody.
> >
> >Since this also breaks the console (i.e., changes the behaviour)
> >It should probably not be on by default: a command-line option or
> >/proc/sys/kernel tweak should be required in order to turn it on.
> >Otherwise, this is likely to get activated unconditionally in production
> >kernels.
> 
> It hadn't really occurred to me that it would ever be a good idea to
> activate this for production kernels. Aren't these code paths rather

Maybe, but there's no way to force people not to.  In general, many
useful debugging options are left on in production kernels :)

This is useful (since production kernels are not really bug-free, and
debugging tools are therefore useful), but it means that debugging
options should be low-overhead and unobtrusive unless something extra
is done explicitly to turn them on...

> hot when the serial ports are running as super high speeds?

It's probably not that bad, since this processing is only done for the
console and not other ports -- I don't know whether a serial port would
ever be used for the the console and simultaneously for some other high-
throughput purpose, since random printk spam is going to break most
protocols...

> That said if the magic string were configurable then it could simply
> default to the empty string and that would result in the serial
> break emulation being disabled.
> 
> 
> >A particular concern is that something other than a human user could be
> >connected to the UART.
> >
> >I also feel it doesn't really belong in this series.  NMI doesn't
> >require this in order to be useful, this patch doesn't require NMI, and
> >anyway it's not specific to arm.
> 
> To be clear I included the patch in this series only because:
> 
> 1. I couldn't figure out any way to send a serial break to the ARM
>    Foundation Model making it impossible for me to provoke SysRq actions
>    from interrupt context,

Agreed, there's no direct way to do it (annoyingly).

Arguably that's a deficiency in the model, though that's not much help to
you right now.

> 2. SysRq-L is a really good way to test the code and, when launched
>    from interrupt context proves that pre-emption by pseudo-NMI works.
> 
> I only really included the patch as a convenience for anyone wanting
> to do any runtime testing.

Sure, that's all fine.

[...]

Cheers
---Dave
