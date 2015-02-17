From: takahiro.akashi@linaro.org (AKASHI Takahiro)
Date: Tue, 17 Feb 2015 09:12:19 +0900
Subject: [PATCH Resend] ARM64:ftrace: fix ftrace_modify_graph_caller for
 branch replace
In-Reply-To: <ce66ac4d80d4b200a9dad610d46533bb24934352.1423800192.git.panand@redhat.com>
References: <ce66ac4d80d4b200a9dad610d46533bb24934352.1423800192.git.panand@redhat.com>
Message-ID: <54E28763.5080708@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/13/2015 01:06 PM, Pratyush Anand wrote:
> ftrace_enable_ftrace_graph_caller and ftrace_disable_ftrace_graph_caller
> should replace B(jmp) instruction and not BL(call) instruction.

Thanks. I originally intended to use "b".
("bl" may also work anyway 'cause link register will be saved/restored
around ftrace_caller().)

-Takahiro AKASHI

> commit 9f1ae7596aad("arm64: Correct ftrace calls to
> aarch64_insn_gen_branch_imm()") did a typo and used
> AARCH64_INSN_BRANCH_LINK instead of AARCH64_INSN_BRANCH_NOLINK.
>
> Signed-off-by: Pratyush Anand <panand@redhat.com>
> ---
>   arch/arm64/kernel/ftrace.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/arm64/kernel/ftrace.c b/arch/arm64/kernel/ftrace.c
> index cf8556ae09d0..c851be795080 100644
> --- a/arch/arm64/kernel/ftrace.c
> +++ b/arch/arm64/kernel/ftrace.c
> @@ -156,7 +156,7 @@ static int ftrace_modify_graph_caller(bool enable)
>
>   	branch = aarch64_insn_gen_branch_imm(pc,
>   					     (unsigned long)ftrace_graph_caller,
> -					     AARCH64_INSN_BRANCH_LINK);
> +					     AARCH64_INSN_BRANCH_NOLINK);
>   	nop = aarch64_insn_gen_nop();
>
>   	if (enable)
>
