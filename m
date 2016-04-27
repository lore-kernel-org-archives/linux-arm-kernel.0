From: catalin.marinas@arm.com (Catalin Marinas)
Date: Wed, 27 Apr 2016 11:24:23 +0100
Subject: [PATCH] arm64: fix /proc/cpuinfo for elf32
In-Reply-To: <678F3D1BB717D949B966B68EAEB446ED0A6E7595@SZXEMA509-MBX.china.huawei.com>
References: <1461555453-60440-1-git-send-email-prime.zeng@huawei.com>
 <20160425091239.GB9614@e104818-lin.cambridge.arm.com>
 <678F3D1BB717D949B966B68EAEB446ED0A6E6FB7@SZXEMA509-MBX.china.huawei.com>
 <571F32F3.7080005@arm.com>
 <678F3D1BB717D949B966B68EAEB446ED0A6E7595@SZXEMA509-MBX.china.huawei.com>
Message-ID: <20160427102422.GB20646@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 27, 2016 at 02:13:01AM +0000, Zengtao (B) wrote:
> Suzuki K Poulose wrote:
> > On 26/04/16 03:21, Zengtao (B) wrote:
> > > So you mean the 64-bit grep should see the same cpuinfo as its father process
> > > which is 32-bit?
> > >
> > > For 32-bit process running on 64-bit kernel, we have to explicitly
> > > call the personality syscall to get the right cpuinfo, but how to
> > > deal with the old 32-bit binaries?
> > 
> > Yes, you could use the syscall to switch the personality.
> > Alternately, you could run "linux32" command to switch the
> > personality to PER_LINUX32 and then execute 64/32 bit applications.
> 
> Any plan to place the personality syscall in libc? It is not nessary
> for each 32-bit process to do the personality syscall or linux32
> command. 

The problem is that the personality will be inherited by child
processes, so any 64-bit process started by a 32-bit one would get the
wrong /proc/cpuinfo. In some cases this is desirable (e.g. system(3)
invoking grep to parse /proc/cpuinfo) while in others not (predominantly
32-bit system with a few 64-bit applications).

Reading /proc/cpuinfo from application is wrong in general but I think
it's too late to do anything about it now.

Anyway, some past discussion here:

http://lists.infradead.org/pipermail/linux-arm-kernel/2014-November/300400.html

The decision at the time was for /proc/cpuinfo to mimic the "uname -m"
behaviour, IOW always reporting "aarch64" unless you set PER_LINUX32.
What you are proposing now is point (c) in the thread above.

We could propose another option (combination of (c) and (d)) but it
requires wider discussion:

[e] Print different hwcaps for compat *or* PER_LINUX32 tasks

This way unmodified compat tasks can be invoked directly (without
linux32) and get the 32-bit hwcaps. For trickier uses like system("grep
/proc/cpuinfo") I don't see any other way than setting PER_LINUX32.

-- 
Catalin
