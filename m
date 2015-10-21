From: Dave.Martin@arm.com (Dave Martin)
Date: Wed, 21 Oct 2015 10:00:51 +0100
Subject: [PATCHv4 06/24] arm64: Move /proc/cpuinfo handling code
In-Reply-To: <1445261101-22344-7-git-send-email-suzuki.poulose@arm.com>
References: <1445261101-22344-1-git-send-email-suzuki.poulose@arm.com>
 <1445261101-22344-7-git-send-email-suzuki.poulose@arm.com>
Message-ID: <20151021090050.GG4801@e103592.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 19, 2015 at 02:24:43PM +0100, Suzuki K. Poulose wrote:
> This patch moves the /proc/cpuinfo handling code:
> 
> arch/arm64/kernel/{setup.c to cpuinfo.c}
> 
> No functional changes
> 
> Signed-off-by: Suzuki K. Poulose <suzuki.poulose@arm.com>

[...]

> diff --git a/arch/arm64/kernel/cpuinfo.c b/arch/arm64/kernel/cpuinfo.c
> index 8307b33..0dadb69 100644
> --- a/arch/arm64/kernel/cpuinfo.c
> +++ b/arch/arm64/kernel/cpuinfo.c

[...]

> @@ -45,6 +48,127 @@ static char *icache_policy_str[] = {
>  
>  unsigned long __icache_flags;
>  
> +static const char *hwcap_str[] = {

[...]

> +#ifdef CONFIG_COMPAT
> +static const char *compat_hwcap_str[] = {

[...]

> +static const char *compat_hwcap2_str[] = {

[...]

I still have a random cleanup patch knocking around for constifying
these arrays.

It's probably best kept separate so that your patch just moves code
around, but feel free to add my patch to the series if you want.

Cheers
---Dave

>From ab00f84e4d45e95b4d816961a0160f1d448aa886 Mon Sep 17 00:00:00 2001
From: Dave Martin <Dave.Martin@arm.com>
Date: Thu, 30 Jul 2015 16:36:25 +0100
Subject: [PATCH 1/2] arm64: Constify hwcap name string arrays

The hwcap string arrays used for generating the contents of
/proc/cpuinfo are currently arrays of non-const pointers.

There's no need for these pointers to be mutable, so this patch makes
them const so that they can be moved to .rodata.

Signed-off-by: Dave Martin <Dave.Martin@arm.com>
---
 arch/arm64/kernel/cpuinfo.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/kernel/cpuinfo.c b/arch/arm64/kernel/cpuinfo.c
index 349ebf7..20b7748 100644
--- a/arch/arm64/kernel/cpuinfo.c
+++ b/arch/arm64/kernel/cpuinfo.c
@@ -48,7 +48,7 @@ static char *icache_policy_str[] = {
 
 unsigned long __icache_flags;
 
-static const char *hwcap_str[] = {
+static const char *const hwcap_str[] = {
 	"fp",
 	"asimd",
 	"evtstrm",
@@ -63,7 +63,7 @@ static const char *hwcap_str[] = {
 };
 
 #ifdef CONFIG_COMPAT
-static const char *compat_hwcap_str[] = {
+static const char *const compat_hwcap_str[] = {
 	"swp",
 	"half",
 	"thumb",
@@ -88,7 +88,7 @@ static const char *compat_hwcap_str[] = {
 	"evtstrm"
 };
 
-static const char *compat_hwcap2_str[] = {
+static const char *const compat_hwcap2_str[] = {
 	"aes",
 	"pmull",
 	"sha1",
-- 
1.7.10.4
