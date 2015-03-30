From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Mon, 30 Mar 2015 13:49:25 +0200
Subject: [RFC PATCH 0/2] ARM large kernels
Message-ID: <1427716167-25078-1-git-send-email-ard.biesheuvel@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello all,

After Russell has pulled most of the large kernel fixes that are
specific to the ARM tree, these two patches are the remaining ones
that are required to successfully build 'allyesconfig' on ARM (*)

The first one updates scripts/kallsyms.c to ignore _veneer symbols.
These are emitted by the linker, and due to the fact that the kallsyms
region is empty in the first pass, and populated in the second, the
number of emitted veneers changes, which changes the contents of
the symbol table etc etc

The second patch keeps the contents of drivers/built-in.o into as
separate inputs into the final link stage. This ensures that the
linker can emit the veneers against out-of-range functions in a
location that is not out of range itself.

(*) It produces a ~75 MB zImage; whether it runs is another question

Ard Biesheuvel (2):
  Kbuild: kallsyms: ignore veneers emitted by the ARM linker
  Kbuild: avoid partial linking of drivers/built-in.o

 Makefile           | 12 +++++++++++-
 scripts/kallsyms.c | 17 ++++++++++++++---
 2 files changed, 25 insertions(+), 4 deletions(-)

-- 
1.8.3.2
