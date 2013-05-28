From: will.deacon@arm.com (Will Deacon)
Date: Tue, 28 May 2013 11:42:50 +0100
Subject: [PATCH v2] arch: arm64: kernel: sprintf(), 'str' needs
 additional 1 byte for failure processing
In-Reply-To: <51A2BE2C.2000004@asianux.com>
References: <51A1E3B3.4060901@asianux.com>
 <51A2BE2C.2000004@asianux.com>
Message-ID: <20130528104250.GE10474@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On Mon, May 27, 2013 at 03:00:12AM +0100, Chen Gang wrote:
> 
> When failure occurs at the last looping cycle (when 'i == 0'), it will
> print "bad PC value" instead of "(%08x) ", which needs additional 1
> byte.
> 
> If not add 1 byte, the 'str' may be memory overflow.
> 
> 
> Signed-off-by: Chen Gang <gang.chen@asianux.com>
> ---
>  arch/arm64/kernel/traps.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/arch/arm64/kernel/traps.c b/arch/arm64/kernel/traps.c
> index 61d7dd2..c2f68d2 100644
> --- a/arch/arm64/kernel/traps.c
> +++ b/arch/arm64/kernel/traps.c
> @@ -100,7 +100,7 @@ static void dump_instr(const char *lvl, struct pt_regs *regs)
>  {
>  	unsigned long addr = instruction_pointer(regs);
>  	mm_segment_t fs;
> -	char str[sizeof("00000000 ") * 5 + 2 + 1], *p = str;
> +	char str[sizeof("00000000 ") * 5 + 2 + 1 + 1], *p = str;
>  	int i;

Whilst this code is difficult to follow, I don't think it's incorrect.
The size of the str array is:

	sizeof("00000000 ") = 8 ('0's) + 1 (space) + 1 (NUL) = 10 bytes
	*5 = 50 bytes
	+2 (for the two brackets when i == 0) = 52 bytes
	+1 (this is for the "bad PC value") = 53 bytes

In the worst case (when the PC is bad) we print:

	"%08x " x4 = (8 + 1 + 1) *4 = 40 bytes
	"bad PC value" = 12 + 1 = 13 bytes

so again, 53 bytes.

... or have I missed a character somewhere?

Will
