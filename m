From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 23 May 2013 12:59:43 +0200
Subject: [PATCH] arch: configuration,
 deleting 'CONFIG_BUG' since always need it.
In-Reply-To: <20130523100409.GK18614@n2100.arm.linux.org.uk>
References: <519DCBEF.3090208@asianux.com> <201305231139.38233.arnd@arndb.de>
 <20130523100409.GK18614@n2100.arm.linux.org.uk>
Message-ID: <201305231259.43750.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 23 May 2013, Russell King - ARM Linux wrote:
> So, if you want to use this, then you should update the CONFIG_BUG text
> to include a warning to this effect:
> 
>      Warning: if CONFIG_BUG is turned off, and control flow reaches
>      a BUG(), the system behaviour will be undefined.
> 
> so that people can make an informed choice about this, because at the
> moment:
> 
>           Disabling this option eliminates support for BUG and WARN, reducing
>           the size of your kernel image and potentially quietly ignoring
>           numerous fatal conditions. You should only consider disabling this
>           option for embedded systems with no facilities for reporting errors.
>           Just say Y.
> 
> will become completely misleading.  Turning this option off will not
> result in "quietly ignoring numerous fatal conditions".

I must be missing something, to me the two descriptions mean the same thing.

> And I come back to one of my previous arguments - is it not better to
> panic() if we hit one of these conditions so that the system can try to
> do a panic-reboot rather than continue blindly into the unknown?

I think this all comes from the 'linux-tiny' project that tried to squeeze
out the last bits of kernel object code size at some point. The idea was
that if you have code like

	BUG_ON(something_unexpected_happened());

or

	switch (my_enum) {
	case FOO:
		return f1();
	case BAR:
		return f2();
	default:
		BUG();
	}

You don't just want to avoid the code for printing the bug message and
the invalid instruction, we also want the compiler to not emit the 
function call or check the enum for unexpected values. The meaning of
BUG() is really that person writing that statement was sure it cannot
happen unless there is a bug in the kernel, which has likely already
corrupted data. Printing a diagnostic at this point is nice if someone
is there to look at it, but letting the kernel do further actions that
may be undefined is not going to make things worse.

	Arnd
