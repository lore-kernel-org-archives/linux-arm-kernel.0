From: catalin.marinas@arm.com (Catalin Marinas)
Date: Thu, 7 Nov 2013 17:50:11 +0000
Subject: [PATCH trivial] arm64: constify hwcap_str
In-Reply-To: <1383755567-17244-1-git-send-email-ard.biesheuvel@linaro.org>
References: <1383755567-17244-1-git-send-email-ard.biesheuvel@linaro.org>
Message-ID: <20131107175010.GI13674@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 06, 2013 at 04:32:47PM +0000, Ard Biesheuvel wrote:
> Turn hwcap_str from a 'writable array of pointers to const char[]'
> to a multidimensional const char[][].
> 
> Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> ---
> 
> This is something I noticed when looking at Steve Capper's hwcaps patch: really
> no point in having a writable array of 8-byte pointers in .data keeping track of
> these hwcap strings.

I don't see a problem (few bytes wasted). If you want to make it
read-only, this would do:

diff --git a/arch/arm64/kernel/setup.c b/arch/arm64/kernel/setup.c
index 9cf30f49610d..84a770fd7003 100644
--- a/arch/arm64/kernel/setup.c
+++ b/arch/arm64/kernel/setup.c
@@ -308,7 +308,7 @@ static int __init topology_init(void)
 }
 subsys_initcall(topology_init);
 
-static const char *hwcap_str[] = {
+static const char *const hwcap_str[] = {
 	"fp",
 	"asimd",
 	NULL

-- 
Catalin
