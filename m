From: tglx@linutronix.de (Thomas Gleixner)
Date: Tue, 10 Nov 2015 10:55:49 -0500 (EST)
Subject: [PATCH v2 1/7] timekeeping: introduce __current_kernel_time64
In-Reply-To: <CALAqxLU35iSG8dCgkKi9v_mM=xO1p1jWAhq3nX6_CAYcjUYoZQ@mail.gmail.com>
References: <alpine.DEB.2.02.1511101131350.5676@kaball.uk.xensource.com>
 <1447156675-7418-1-git-send-email-stefano.stabellini@eu.citrix.com>
 <4372800.FdTygmcuyo@wuerfel>
 <alpine.DEB.2.02.1511101507540.5676@kaball.uk.xensource.com>
 <CALAqxLUEOWP6CJxY021nDR6cEQf3VZtm8fa9waK2a=OmQJEO-g@mail.gmail.com>
 <alpine.DEB.2.11.1511101028320.3915@nanos>
 <CALAqxLU35iSG8dCgkKi9v_mM=xO1p1jWAhq3nX6_CAYcjUYoZQ@mail.gmail.com>
Message-ID: <alpine.DEB.2.11.1511101046420.3915@nanos>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 10 Nov 2015, John Stultz wrote:
> I'm sort of objecting to a different issue, where the
> __current_kernel_time() implementation probably shouldn't be grabbing
> the tk_core.timekeeper directly, and instead should take a passed
> pointer to a timekeeper. The vdso/pv_clock usage should have a
> timekeeper passed to them that they could use.

That usage of __current_kernel_time() in that xen notifier is silly to
begin with. The notifier gets already called with a pointer to the
time keeper. That xen implementation just does not use it.

We extract exactly that information in the vdso updates without
calling back into the core code. So for solving that xen thing we do
not need a 64 bit variant of __current_kernel_time() at all. The
notifier has the pointer to the timekeeper and can just grab data from
there.

> There's one useage in kdb thats maybe problematic, so maybe this will
> need a deeper cleanup.

That one is silly as well. It only wants to know the seconds portion.

Thanks,

	tglx
