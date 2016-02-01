From: eric.auger@linaro.org (Eric Auger)
Date: Mon, 1 Feb 2016 18:27:33 +0100
Subject: [PATCH] vfio: pci: fix oops in case of vfio_msi_set_vector_signal
 failure
In-Reply-To: <1454103676.9301.3.camel@redhat.com>
References: <1454078586-5431-1-git-send-email-eric.auger@linaro.org>
 <1454103676.9301.3.camel@redhat.com>
Message-ID: <56AF9585.1000904@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Alex,
On 01/29/2016 10:41 PM, Alex Williamson wrote:
> On Fri, 2016-01-29 at 14:43 +0000, Eric Auger wrote:
>> In case vfio_msi_set_vector_signal fails we tear down everything.
>> In the tear down loop we compare int j against unsigned start. Given
>> the arithmetic conversion I think it is converted into an unsigned and
>> becomes 0xffffffff, leading to the loop being entered again and things
>> turn bad when accessing vdev->msix[vector].vector. So let's use int
>> parameters instead.
>>  
>> Signed-off-by: Eric Auger <eric.auger@linaro.org>
>> ---
>>  drivers/vfio/pci/vfio_pci_intrs.c | 4 ++--
>>  1 file changed, 2 insertions(+), 2 deletions(-)
>>  
>> diff --git a/drivers/vfio/pci/vfio_pci_intrs.c b/drivers/vfio/pci/vfio_pci_intrs.c
>> index 3b3ba15..510c48d 100644
>> --- a/drivers/vfio/pci/vfio_pci_intrs.c
>> +++ b/drivers/vfio/pci/vfio_pci_intrs.c
>> @@ -374,8 +374,8 @@ static int vfio_msi_set_vector_signal(struct vfio_pci_device *vdev,
>>  	return 0;
>>  }
>>  
>> -static int vfio_msi_set_block(struct vfio_pci_device *vdev, unsigned start,
>> -			      unsigned count, int32_t *fds, bool msix)
>> +static int vfio_msi_set_block(struct vfio_pci_device *vdev, int start,
>> +			      int count, int32_t *fds, bool msix)
>>  {
>>  	int i, j, ret = 0;
>>  
> 
> Nice find, I don't think that's the only bug there though.  If @start is
> -1 (UINT32_MAX) and @count is 1, then @j gets set to -1 in the setup and
> we hit the same index dereference problem.  What if we did this instead:
> 
> diff --git a/drivers/vfio/pci/vfio_pci_intrs.c b/drivers/vfio/pci/vfio_pci_intrs.c
> index 3b3ba15..2ae84ad 100644
> --- a/drivers/vfio/pci/vfio_pci_intrs.c
> +++ b/drivers/vfio/pci/vfio_pci_intrs.c
> @@ -309,14 +309,14 @@ static int vfio_msi_set_vector_signal(struct vfio_pci_device *vdev,
>  				      int vector, int fd, bool msix)
>  {
>  	struct pci_dev *pdev = vdev->pdev;
> -	int irq = msix ? vdev->msix[vector].vector : pdev->irq + vector;
> -	char *name = msix ? "vfio-msix" : "vfio-msi";
>  	struct eventfd_ctx *trigger;
> -	int ret;
> +	int irq, ret;
>  
> -	if (vector >= vdev->num_ctx)
> +	if (vector < 0 || vector >= vdev->num_ctx)
>  		return -EINVAL;
>  
> +	irq = msix ? vdev->msix[vector].vector : pdev->irq + vector;
> +
>  	if (vdev->ctx[vector].trigger) {
>  		free_irq(irq, vdev->ctx[vector].trigger);
>  		irq_bypass_unregister_producer(&vdev->ctx[vector].producer);
> @@ -328,8 +328,9 @@ static int vfio_msi_set_vector_signal(struct vfio_pci_device *vdev,
>  	if (fd < 0)
>  		return 0;
>  
> -	vdev->ctx[vector].name = kasprintf(GFP_KERNEL, "%s[%d](%s)",
> -					   name, vector, pci_name(pdev));
> +	vdev->ctx[vector].name = kasprintf(GFP_KERNEL, "vfio-msi%s[%d](%s)",
> +					   msix ? "x" : "", vector,
> +					   pci_name(pdev));
>  	if (!vdev->ctx[vector].name)
>  		return -ENOMEM;
>  
> @@ -379,7 +380,7 @@ static int vfio_msi_set_block(struct vfio_pci_device *vdev, unsigned start,
>  {
>  	int i, j, ret = 0;
>  
> -	if (start + count > vdev->num_ctx)
> +	if (start >= vdev->num_ctx || start + count > vdev->num_ctx)
>  		return -EINVAL;
>  
>  	for (i = 0, j = start; i < count && !ret; i++, j++) {
> @@ -388,7 +389,7 @@ static int vfio_msi_set_block(struct vfio_pci_device *vdev, unsigned start,
>  	}
>  
>  	if (ret) {
> -		for (--j; j >= start; j--)
> +		for (--j; j >= 0 && j >= start; j--)
>  			vfio_msi_set_vector_signal(vdev, j, -1, msix);
>  	}
>  
> 
> So we fix the problem with vfio_msi_set_vector_signal() dereferencing
> the array before it validates the index (even though it shouldn't be
> able to get there anymore), and then we do a better job of verifying
> start and count (comparing to num_ctx will use unsigned even though
> num_ctx itself is signed) and finally explicitly test the <0 case, which
> I suppose we could also do by casting start at that point (we know it's
> within the bounds of a signed integer given the previous tests).

Yes it looks OK to me.

I guess you submit? I will test it.

Best Regards

Eric
> Thanks,
> 
> Alex
> 
