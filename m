From: geoff@infradead.org (Geoff Levand)
Date: Fri, 31 Oct 2014 16:25:39 -0700
Subject: [PATCH 00/10] arm64 kexec kernel patches V5
In-Reply-To: <20141031075209.GH3290@darkstar.nay.redhat.com>
References: <cover.1414099246.git.geoff@infradead.org>
 <20141031075209.GH3290@darkstar.nay.redhat.com>
Message-ID: <1414797939.23621.38.camel@smoke>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Dave,

Thanks for testing.

On Fri, 2014-10-31 at 15:52 +0800, Dave Young wrote:
> I tested your patches. The macihne is using spin-table cpu enable method
> so I tried maxcpus=1 as you suggested.
> 
> There's below issues for me, thoughts?
> 
> 1. For acpi booting there's no /proc/device-tree so kexec can not find dtb
> to use.

You can supply a DTB with the kexec --dtb option, then kexec will not need
/proc/device-tree.  Please try if you can and let me know what happens.

> 2. adding "acpi=off" to 1st kernel boot cmdline, kexec load fails with error
> like below:
> machine_apply_elf_rel: ERROR Unknown type: 261
> 
> I did below hack then kexec load works fine, 

OK, thanks, I'll add support for R_AARCH64_PREL32 in.

> but `kexec -e` still does not work
> there's nothing more than "Disableing non-boot CPUS ...\n Bye!":

It is really tough to say what happened.  The 'Bye!' message is printed
just before the 1st stage kernel exits and the 2nd stage kernel is
entered.  If you have a debugger you can put some breakpoints in
there to see how far it gets.  That is generally how I figure out
what went wrong.

You could try the kexec --lite option, it will do a non-purgatory
boot.

You could also try my master branch that has more debugging output.
Some of it is through the VE's serial port, so you may need to
change that to what your platform has.

-Geoff
