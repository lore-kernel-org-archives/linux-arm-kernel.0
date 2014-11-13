From: Ulrich.Weigand@de.ibm.com (Ulrich Weigand)
Date: Thu, 13 Nov 2014 15:49:20 +0100
Subject: [RFC] ptrace: add generic SET_SYSCALL request
In-Reply-To: <3899236.yrOvvrZHD6@wuerfel>
References: <1415346443-28915-1-git-send-email-takahiro.akashi@linaro.org>
 <6358312.yt5WU3kBm9@wuerfel> <54645799.5010409@linaro.org>
 <3899236.yrOvvrZHD6@wuerfel>
Message-ID: <OF152076B7.38277C08-ONC1257D8F.0050C2DF-C1257D8F.00516BF2@de.ibm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Arnd Bergmann <arnd@arndb.de> wrote on 13.11.2014 11:21:28:

> I have to admit that I don't really understand gdb internals, but from
> a first look I get the impression that it will just do the right thing
> if you reuse NT_S390_SYSTEM_CALL on ARM64 with the same semantics.

There's an interface between BFD and GDB proper involved here.  BFD will
detect the presence of register set notes in the core dump, and will
translate them into virtual sections; GDB will then simply look up such
sections under well-known names.

In particular, the NT_S390_SYSTEM_CALL note will be translated by BFD
into a virtual section named ".reg-s390-system-call"; GDB platform-
specific code will look for sections of this particular name.

So if you were to create notes using the same note type, by default it
would do nothing on ARM64.  You might add code to the ARM64 back-end
to also look for a section ".reg-s390-system-call", but that would be
somewhat confusing.  Using a new, platform-specific note type for ARM64
would appear to fit better with existing precedent.

Bye,
Ulrich
