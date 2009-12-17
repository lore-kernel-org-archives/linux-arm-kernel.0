From: r-woodruff2@ti.com (Woodruff, Richard)
Date: Thu, 17 Dec 2009 12:19:57 -0600
Subject: [PATCH] ARM: Add SWP/SWPB emulation for ARMv7 processors
In-Reply-To: <20091217175416.9317.66257.stgit@e101986-lin>
References: <20091217175416.9317.66257.stgit@e101986-lin>
Message-ID: <13B9B4C6EF24D648824FF11BE896716203A7FA69CC@dlee02.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


> From: linux-arm-kernel-bounces at lists.infradead.org [mailto:linux-arm-kernel-
> bounces at lists.infradead.org] On Behalf Of Leif Lindholm
> Sent: Thursday, December 17, 2009 11:54 AM

> The SWP instruction was deprecated in the ARMv6 architecture, superseded
> by the LDREX/STREX family of instructions for
> load-linked/store-conditional operations. The ARMv7 multiprocessing
> extensions mandate that SWP/SWPB instructions are treated as undefined
> from reset, with the ability to enable them through the System Control
> Register SW bit.
>
> This patch adds the alternative solution to emulate the SWP and SWPB
> instructions using LDREX/STREX sequences, and log statistics to
> /proc/cpu/swp_emulation. To correctly deal with copy-on-write, it also
> modifies cpu_v7_set_pte_ext to change the mappings to priviliged RO when
> user RO.

Exclusive operations are more certainly more efficient than the full bus lock behavior of SWP.  Finding and killing SWP where possible seems positive.

Still, the exclusive operations for some systems don't extend beyond an ARM smp-cluster. Not all cores and interconnect implementations support the range lock.  As such from a SOC point of view SWP still has value as it may exist where lwrex/swrex would fail. It is also much lighter than using some kind of mailbox alternative.

While the ARM is important to many SOCs its not the whole thing.  I've seen some side threads where people are busy blindly removing SWP and quoting half information.

My main comment on patch in this regard is to make the point you won't be able to fully emulate a SWP with the sequence you posted if you consider other cores outside the ARM cluster. Some note to that effect would be positive in the description.

Regards,
Richard W.
