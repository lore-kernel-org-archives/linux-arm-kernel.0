From: matt@codeblueprint.co.uk (Matt Fleming)
Date: Sun, 24 Apr 2016 22:12:12 +0100
Subject: [PATCHv2 1/6] efi/runtime-wrappers: add {__,}efi_call_virt
 templates
In-Reply-To: <1461333083-15529-2-git-send-email-mark.rutland@arm.com>
References: <1461333083-15529-1-git-send-email-mark.rutland@arm.com>
 <1461333083-15529-2-git-send-email-mark.rutland@arm.com>
Message-ID: <20160424211212.GM2829@codeblueprint.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 22 Apr, at 02:51:18PM, Mark Rutland wrote:
> Currently each architecture must implement two macros, efi_call_virt and
> __efi_call_virt, which only differ by the presence or absence of a
> return type. Otherwise, the logic surrounding the call is identical.
> 
> As each architecture must define the entire body of each, we can't place
> any generic manipulation (e.g. irq flag validation) in the middle.
> 
> This patch adds template implementations of these macros. With these,
> arch code can implement three template macros, avoiding reptition for
> the void/non-void return cases:
> 
> * arch_efi_call_virt_setup
> 
>   Sets up the environment for the call (e.g. switching page tables,
>   allowing kernel-mode use of floating point, if required).
> 
> * arch_efi_call_virt
> 
>   Performs the call. The last expression in the macro must be the call
>   itself, allowing the logic to be shared by the void and non-void
>   cases.
> 
> * arch_efi_call_virt_teardown
> 
>   Restores the usual kernel environment once the call has returned.
> 
> While the savings from repition are minimal, we additionally gain the
> ability to add common code around the call with the call environment set
> up. This can be used to detect common firmware issues (e.g. bad irq mask
> management).
> 
> Signed-off-by: Mark Rutland <mark.rutland@arm.com>
> Reviewed-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> Cc: Matt Fleming <matt@codeblueprint.co.uk>
> Cc: linux-efi at vger.kernel.org
> Cc: linux-kernel at vger.kernel.org
> ---
>  drivers/firmware/efi/runtime-wrappers.c | 21 +++++++++++++++++++++
>  1 file changed, 21 insertions(+)

Applied. I incorporated the explanation of the 3 template macros next
to the code because it is too useful to only have it exist in the git
commit history.
