From: dave.martin@linaro.org (Dave Martin)
Date: Tue, 3 May 2011 12:07:53 +0100
Subject: Runtime CPU features detection on ARM (/proc/cpuinfo vs.
	/proc/self/auxv)
In-Reply-To: <BANLkTikaHJhz2JVceVUtZnwOdS_egixifg@mail.gmail.com>
References: <BANLkTikaHJhz2JVceVUtZnwOdS_egixifg@mail.gmail.com>
Message-ID: <20110503110753.GA2619@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 27, 2011 at 12:53:44AM +0300, Siarhei Siamashka wrote:
> Hi All,
> 
> Is the format of /proc/cpuinfo stable and guaranteed to remain the
> same in the future versions of the linux kernel? I did a bit of
> searching over the mailing lists and [1], [2] suggest that it is
> highly likely. I apologize if I missed something and this question is
> supposed to have been already answered, but I still would like to have
> a clear confirmation just in case. Additionally, the most
> authoritative source of information preferably would be some text file
> under 'Documentation/arm' directory in the linux kernel sources,
> formally describing /proc/cpuinfo format as needed for the automated
> parsers.
> 
> At least one more alternative for detecting cpu features is to use
> AT_HWCAP from ELF auxiliary vector. But unfortunately it turned out to
> have some practical issues with qemu-user [3] and valgrind [4]. Using
> /proc/cpuinfo also provides more information about the cpu type and
> its revision, which could be used to get more performance for each
> particular cpu variant and avoid hardware bugs. Looks like 'Features',
> 'CPU implementer', 'CPU architecture', 'CPU variant', 'CPU part' and
> 'CPU revision' have more or less complete set of information about the
> processor for userspace applications.
> 
> Or maybe somebody can suggest a better method for runtime CPU features
> detection? Thanks.

I've come across similar problems in the recent past to do with NEON
optimisations in userspace.

auxv and /proc/cpuinfo seem to be the most usable options, though both
have their limitations.

auxv doesn't feel practical to extend to cover general information about the
SoC/board, though for instruction set feature detection it is adequate for
most cases.

Boards can and do put their own stuff in /proc/cpuinfo,
which often makes it possible to detect specific parts and hardware revisions,
but I don't think this is well standardised/formalised.  Also, if software
actually makes decisions based on what precise board/SoC it's running on,
this implies applications possibly needing a huge database of quirks for different
boards which would be a maintenance nightmare.  So there's an argument for
keeping it difficult for userspace software to find out this information in
any automatable way.

The low-hanging fruit for a generic solution might be to formalise what's
in/proc/cpuinfo and clarify what should and should not be present there,
particularly since there a de facto format for it already, and some userspace software
already makes use of it.

Perhaps a sysfs interface to this information would be a more robust and
flexible approach for the future, with the potential to benefit other
architectures too (since I'm not sure these problems are well solved on any
arch, though that could just be my ignorance talking...)

Cheers
---Dave

> 
> 
> 1. http://lists.arm.linux.org.uk/lurker/message/20090226.082730.69926605.en.html
> 2. http://lists.arm.linux.org.uk/lurker/message/20091112.221307.62810e83.en.html
> 3. http://comments.gmane.org/gmane.comp.graphics.pixman/733
> 4. http://bugs.kde.org/show_bug.cgi?id=253519
> 
> -- 
> Best regards,
> Siarhei Siamashka
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
