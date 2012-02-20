From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 20 Feb 2012 16:16:01 +0000
Subject: [PATCHv2 1/6] ARM: ftrace: remove useless memory checks
In-Reply-To: <1327757725-10114-2-git-send-email-rabin@rab.in>
References: <1327757725-10114-1-git-send-email-rabin@rab.in>
 <1327757725-10114-2-git-send-email-rabin@rab.in>
Message-ID: <20120220161601.GH26840@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Jan 28, 2012 at 07:05:20PM +0530, Rabin Vincent wrote:
> Before replacing an instruction, the ftrace code determines what the old
> instruction should be and verifies that that's what's really there in
> memory before replacing it.  This is useful if for example a bug in
> mcountrecord causes it to record wrong locations.
> 
> However, in cases where we replace call sites in entry-common.S, these
> checks are not needed.  For these, we currently just memcpy() the memory
> content and then "verify" it -- this is quite useless and can be
> removed.

Yes, I know this is a little late, but...

> 
> Signed-off-by: Rabin Vincent <rabin@rab.in>
> ---
>  arch/arm/kernel/ftrace.c |   18 +++++++++---------
>  1 files changed, 9 insertions(+), 9 deletions(-)
> 
> diff --git a/arch/arm/kernel/ftrace.c b/arch/arm/kernel/ftrace.c
> index c0062ad..e9488ad 100644
> --- a/arch/arm/kernel/ftrace.c
> +++ b/arch/arm/kernel/ftrace.c
> @@ -125,11 +125,13 @@ static int ftrace_modify_code(unsigned long pc, unsigned long old,
>  {
>  	unsigned long replaced;
>  
> -	if (probe_kernel_read(&replaced, (void *)pc, MCOUNT_INSN_SIZE))
> -		return -EFAULT;
> +	if (old) {

So, we're using the instruction value '0' to mean that we don't want to
check?  Wouldn'it it be better to pass a flag in to indicate this instead
of creating a magic value?
