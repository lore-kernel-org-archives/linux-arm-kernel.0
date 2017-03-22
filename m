From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 22 Mar 2017 17:29:19 +0100
Subject: [PATCH] [v2] arm64: define BUG() instruction without CONFIG_BUG
In-Reply-To: <20170322153208.GC25645@e104818-lin.cambridge.arm.com>
References: <20170314213939.3874497-1-arnd@arndb.de>
 <20170322143729.GB25645@e104818-lin.cambridge.arm.com>
 <CAK8P3a0A0-gnBnBBuWdPjgoDMo=2P9yXcLjZYm9Yz+xpQnCyCw@mail.gmail.com>
 <20170322153208.GC25645@e104818-lin.cambridge.arm.com>
Message-ID: <CAK8P3a1V37QGtB6EeXptaOgKFz1QE=VObN91r1Ld-0ZOKAPXaQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 22, 2017 at 4:32 PM, Catalin Marinas
<catalin.marinas@arm.com> wrote:
> On Wed, Mar 22, 2017 at 03:51:54PM +0100, Arnd Bergmann wrote:
>> On Wed, Mar 22, 2017 at 3:37 PM, Catalin Marinas
>> <catalin.marinas@arm.com> wrote:

>> Taht was certainly not intended, and I don't see yet what exactly is going on.
>> What is your setting for CONFIG_BUG and CONFIG_BUGVERBOSE?
>
> CONFIG_BUG=y
> CONFIG_DEBUG_BUGVERBOSE=y

Ok, I found the typo, can you just fold this in, or should I send an
updated patch?

 Arnd

diff --git a/arch/arm64/include/asm/bug.h b/arch/arm64/include/asm/bug.h
index bfc6021760e5..ff030254f791 100644
--- a/arch/arm64/include/asm/bug.h
+++ b/arch/arm64/include/asm/bug.h
@@ -49,10 +49,10 @@ _BUGVERBOSE_LOCATION(__FILE__, __LINE__) \

 #define __BUG_FLAGS(flags) \
  asm volatile ( \
- __BUG_ENTRY(0) \
+ __BUG_ENTRY(flags) \
  "brk %[imm]" :: [imm] "i" (BUG_BRK_IMM) \
  );

 #define BUG() do { \
  __BUG_FLAGS(0); \
  unreachable(); \
