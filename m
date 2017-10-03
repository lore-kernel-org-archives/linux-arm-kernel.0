From: stuart.yoder@arm.com (Stuart Yoder)
Date: Tue, 3 Oct 2017 11:05:29 -0500
Subject: [Tee-dev] [PATCH v1 00/14] tee: optee: add dynamic shared memory
 support
In-Reply-To: <1506621851-6929-1-git-send-email-volodymyr_babchuk@epam.com>
References: <1506621851-6929-1-git-send-email-volodymyr_babchuk@epam.com>
Message-ID: <c761d5d8-63f3-2a6e-145d-300260a362af@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 9/28/17 1:03 PM, Volodymyr Babchuk wrote:
> From: Volodymyr Babchuk <vlad.babchuk@gmail.com>
> 
> This patch series enables dynamic shared memory support in the TEE
> subsystem as a whole and in OP-TEE in particular.
> 
> Global Platform TEE specification [1] allows client applications
> to register part of own memory as a shared buffer between
> application and TEE. This allows fast zero-copy communication between
> TEE and REE. But current implementation of TEE in Linux does not support
> this feature.
> 
> Also, current implementation of OP-TEE transport uses fixed size
> pre-shared buffer for all communications with OP-TEE OS. This is okay
> in the most use cases. But this prevents use of OP-TEE in virtualized
> environments, because:
>   a) We can't share the same buffer between different virtual machines
>   b) Physically contiguous memory as seen by VM can be non-contiguous
>      in reality (and as seen by OP-TEE OS) due to second stage of
>      MMU translation.
>   c) Size of this pre-shared buffer is limited.
> 
> So, first part of this patch series adds generic register/unregister
> interface to tee subsystem. Next patches add necessary features
> into OP-TEE driver, so it can use not only static pre-shared buffer,
> but whole RAM to communicate with OP-TEE OS.

As is, the patch series enables dynamic shared memory, but keeps the
assumption that there must static shared memory as well.  In the case
of virtual machines this isn't what we want (at least that's the way
I see KVM working).

The series substantially re-works optee_config_shm_memremap() and it
seems like it would not be that difficult to remove the assumptions that
there _must_ be static shared memory available.

...I have some more specific comments on patch 12/14.

Thanks,
Stuart
