From: alxmtvv@gmail.com (Alex Matveev)
Date: Mon, 20 Nov 2017 22:03:59 +0000
Subject: [PATCH v2 16/18] arm64: crypto: disable LTO for aes-ce-cipher.c
In-Reply-To: <CAKv+Gu9gThj2ZHDBjm2drEjnu8CZAWwR96k8XFFfMkXRmfEgaQ@mail.gmail.com>
References: <20171115213428.22559-1-samitolvanen@google.com>
 <20171115213428.22559-17-samitolvanen@google.com>
 <20171120152014.hftuded4zxwn2r7m@lakrids.cambridge.arm.com>
 <20171120212941.051d11c4@delmar.localdomain>
 <CAKv+Gu9gThj2ZHDBjm2drEjnu8CZAWwR96k8XFFfMkXRmfEgaQ@mail.gmail.com>
Message-ID: <20171120220359.1dcc885a@delmar.localdomain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Sami, this seems to be better solution for aes-ce-cipher.c problem.

Regards,
Alex


>From 6bcdd763b56ce10a77a79373a46fc0e8d9026178 Mon Sep 17 00:00:00 2001
From: Alex Matveev <alxmtvv@gmail.com>
Date: Mon, 20 Nov 2017 21:30:38 +0000
Subject: [PATCH] arm64: crypto: fix typo in aes_sub()

Clang's integrated assembler can't parse "v0.4s[0]" argument of the UMOV
instruction. And, as per ARM ARM, this is incorrect usage:

UMOV <Wd>, <Vn>.<Ts>[<index>]

...

<Ts> For the 32-bit variant: is an element size specifier, encoded in
the "imm5" field. It can have the following values:
	B	when imm5 = xxxx1
	H	when imm5 = xxx10
	S	when imm5 = xx100

Signed-off-by: Alex Matveev <alxmtvv@gmail.com>
---
 arch/arm64/crypto/aes-ce-cipher.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/crypto/aes-ce-cipher.c
b/arch/arm64/crypto/aes-ce-cipher.c index 6a75cd75ed11..e26bedee2c45
100644 --- a/arch/arm64/crypto/aes-ce-cipher.c
+++ b/arch/arm64/crypto/aes-ce-cipher.c
@@ -152,7 +152,7 @@ static u32 aes_sub(u32 input)
 	__asm__("dup	v1.4s, %w[in]		;"
 		"movi	v0.16b, #0		;"
 		"aese	v0.16b, v1.16b		;"
-		"umov	%w[out], v0.4s[0]	;"
+		"umov	%w[out], v0.s[0]	;"
 
 	:	[out]	"=r"(ret)
 	:	[in]	"r"(input)
-- 
2.15.0
