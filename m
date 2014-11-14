From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Fri, 14 Nov 2014 21:40:04 +0300
Subject: [PATCH v2 7/8] arm64/kexec: Add checks for KVM and EFI
In-Reply-To: <1415989719.15847.121.camel@smoke>
References: <cover.1415926876.git.geoff@infradead.org>	
 <b7b2f48822a563bafe2888d7ac8e863731159796.1415926876.git.geoff@infradead.org>	
 <546614D7.8080401@cogentembedded.com> <1415989719.15847.121.camel@smoke>
Message-ID: <54664C84.1040003@cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/14/2014 09:28 PM, Geoff Levand wrote:

> Add runtime checks that fail the arm64 kexec syscall for situations that would
> result in system instability do to problems in the KVM and EFI kernel support.
> These checks should be removed when the KVM and EFI problems are fixed.

> Signed-off-by: Geoff Levand <geoff@infradead.org>
> ---
> v2: Typo fixes.

>   arch/arm64/kernel/machine_kexec.c | 22 ++++++++++++++++++++++
>   1 file changed, 22 insertions(+)

> diff --git a/arch/arm64/kernel/machine_kexec.c b/arch/arm64/kernel/machine_kexec.c
> index 775bcc3..faeb4f1 100644
> --- a/arch/arm64/kernel/machine_kexec.c
> +++ b/arch/arm64/kernel/machine_kexec.c
[...]
> @@ -101,6 +107,22 @@ int machine_kexec_prepare(struct kimage *image)
>
>   	kexec_image_info(image);
>
> +	/* TODO: Remove this message when KVM can support a kexec reboot. */
> +	if (IS_ENABLED(CONFIG_KVM) && is_hyp_mode_available()) {
> +		pr_err("%s: Your kernel is configured with KVM support "
> +			"(CONFIG_KVM=y) which currently does not allow for "
> +			"kexec re-boot.\n", __func__);

    Er, failed to notice the first time: you do not need to break up the 
message. This helps finding the messages in the kernel code. If you would have 
run the patch thru scripst/checkpatch.pl you would have gotten the actual 
warnings about that...

[...]

WBR, Sergei
