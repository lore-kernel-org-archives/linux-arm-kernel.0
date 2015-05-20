From: will.deacon@arm.com (Will Deacon)
Date: Wed, 20 May 2015 10:17:35 +0100
Subject: [PATCH v4 06/12] KVM: arm64: guest debug, add SW break point
 support
In-Reply-To: <1431700035-23479-7-git-send-email-alex.bennee@linaro.org>
References: <1431700035-23479-1-git-send-email-alex.bennee@linaro.org>
 <1431700035-23479-7-git-send-email-alex.bennee@linaro.org>
Message-ID: <20150520091735.GB8986@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Alex,

On Fri, May 15, 2015 at 03:27:09PM +0100, Alex Benn?e wrote:
> This adds support for SW breakpoints inserted by userspace.
> 
> We do this by trapping all guest software debug exceptions to the
> hypervisor (MDCR_EL2.TDE). The exit handler sets an exit reason of
> KVM_EXIT_DEBUG with the kvm_debug_exit_arch structure holding the
> exception syndrome information.
> 
> It will be up to userspace to extract the PC (via GET_ONE_REG) and
> determine if the debug event was for a breakpoint it inserted. If not
> userspace will need to re-inject the correct exception restart the
> hypervisor to deliver the debug exception to the guest.
> 
> Any other guest software debug exception (e.g. single step or HW
> assisted breakpoints) will cause an error and the VM to be killed. This
> is addressed by later patches which add support for the other debug
> types.
> 
> Signed-off-by: Alex Benn?e <alex.bennee@linaro.org>
> Reviewed-by: Christoffer Dall <christoffer.dall@linaro.org>
> 
> ---
> v2
>   - update to use new exit struct
>   - tweak for C setup
>   - do our setup in debug_setup/clear code
>   - fixed up comments
> v3:
>   - fix spacing in KVM_GUESTDBG_VALID_MASK
>   - fix and clarify wording on kvm_handle_guest_debug
>   - handle error case in kvm_handle_guest_debug
>   - re-word the commit message
> v4
>   - rm else leg
>   - add r-b-tag
> 
> diff --git a/Documentation/virtual/kvm/api.txt b/Documentation/virtual/kvm/api.txt
> index ba635c7..33c8143 100644
> --- a/Documentation/virtual/kvm/api.txt
> +++ b/Documentation/virtual/kvm/api.txt

Not sure why, but your patches seem to drop the diffstat which makes it
slightly more onerous for reviewers trying to figure out which bits touch
their trees. Are you removing it manually?

Will
