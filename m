From: ndesaulniers@google.com (Nick Desaulniers)
Date: Fri, 16 Mar 2018 16:52:08 +0000
Subject: arm64 kvm built with clang doesn't boot
In-Reply-To: <2e84a842-96e8-aec4-8b85-9ee879bb323a@arm.com>
References: <CAAeHK+xjnXnrG0p06r-QRcUucYi5vcTJOn3mSS-JVxX9_TYg4w@mail.gmail.com>
 <26a25069-ea1d-5fb3-549c-ab653f454a30@arm.com>
 <CAAeHK+zq4-mw3pCNf3nob3gN-s+aWVq7vUy1p8yY4bU4QYNNMg@mail.gmail.com>
 <2e84a842-96e8-aec4-8b85-9ee879bb323a@arm.com>
Message-ID: <CAKwvOd=-TeLJn9=V_Dmj-X+qcRBcfH8tcktbm33xAx671VCYUw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

+ Sami (Google), Takahiro (Linaro)

Just so I fully understand the problem enough to articulate it, we'd be
looking for the compiler to keep the jump tables for speed (I would guess
-fno-jump-tables would emit an if-else chain) but only emit relative jumps
(not absolute jumps)?

> Perhaps Nick can comment on whether something like
-fno-absolute-addressing would be feasible in clang.

Checked with some of my LLVM friends.  They mentioned that this is tricky
because you need to move the addresses of the jump table from a data
section back into the text section.

Looks like LLVM has an interesting method
`shouldPutJumpTableInFunctionSection` [0]. Unfortunately, it gets
overridden for ELF to always return false. [1]

It looks like there's also a flag `no-jump-tables` [2].  Looks like Sami
has used this in the past in kvm. [3]

It's still probably possible to add this to LLVM, so I can pursue that with
LLVM devs.

> But just for the reference, I'm using 4.16-rc4 with a patch to fix SMCCC
issues that you mentioned.

Is this in regards to: commit "arm64: Add ARM_SMCCC_ARCH_WORKAROUND_1 BP
hardening support"? Has anyone tried to upstream a fix for this?  We
probably want to be very explicit with register widths here.

[0]
https://github.com/llvm-mirror/llvm/blob/a5bd54307b1adacb3df297b9b8010979b9afa4d7/lib/Target/TargetLoweringObjectFile.cpp#L280
[1]
https://github.com/llvm-mirror/llvm/blob/e7676fec11b02e4b698b5ffc99e1901246a7bf66/lib/CodeGen/TargetLoweringObjectFileImpl.cpp#L494
[2]
https://github.com/llvm-mirror/llvm/blob/11f5adb29bf90bc1a40b8bb512afcff4b1ac0f56/lib/Transforms/Utils/SimplifyCFG.cpp#L5233
[3] https://patchwork.kernel.org/patch/10060301/

--
Thanks,
~Nick Desaulniers
