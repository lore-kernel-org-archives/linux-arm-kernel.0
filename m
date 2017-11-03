From: mark.rutland@arm.com (Mark Rutland)
Date: Fri, 3 Nov 2017 18:52:22 +0000
Subject: [PATCH 07/15] arm64: use -mno-implicit-float instead of
 -mgeneral-regs-only
In-Reply-To: <20171103183156.ando3jj5pl2hfk5j@lakrids.cambridge.arm.com>
References: <20171103171203.107569-1-samitolvanen@google.com>
 <20171103171203.107569-9-samitolvanen@google.com>
 <20171103183156.ando3jj5pl2hfk5j@lakrids.cambridge.arm.com>
Message-ID: <20171103185222.k3c5kjo5m7dqieyg@lakrids.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 03, 2017 at 06:31:56PM +0000, Mark Rutland wrote:
> On Fri, Nov 03, 2017 at 10:11:52AM -0700, Sami Tolvanen wrote:
> > From: Greg Hackmann <ghackmann@google.com>
> > 
> > LLVM bug 30792 causes clang's AArch64 backend to crash compiling
> > arch/arm64/crypto/aes-ce-cipher.c.  Replacing -mgeneral-regs-only with
> > -mno-implicit-float is the suggested workaround.
> > 
> > Signed-off-by: Greg Hackmann <ghackmann@google.com>
> > Cc: Matthias Kaehlcke <mka@chromium.org>
> > Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
> 
> Just to check, what happens if you pass both to clang?

Apparently not. However, we can do:

-KBUILD_CFLAGS  += -mgeneral-regs-only $(lseinstr) $(brokengasinst)
+KBUILD_CFLAGS  += $(lseinstr) $(brokengasinst)
+# Clang workaround for https://bugs.llvm.org/show_bug.cgi?id=30792
+KBUILD_CFLAGS  += $(call cc-option, -mno-implicit-float, -mgeneral-regs-only)

Thanks,
Mark.
