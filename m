From: eric.auger@redhat.com (Auger Eric)
Date: Wed, 10 Aug 2016 10:48:02 +0200
Subject: [PATCH v12 02/11] genirq/msi: msi_compose wrapper
In-Reply-To: <alpine.DEB.2.20.1608091117250.5388@nanos>
References: <1470158617-7022-1-git-send-email-eric.auger@redhat.com>
 <1470158617-7022-3-git-send-email-eric.auger@redhat.com>
 <alpine.DEB.2.20.1608091117250.5388@nanos>
Message-ID: <bc3270b2-340b-9396-0722-2c2097f7fae4@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Thomas,

On 09/08/2016 11:19, Thomas Gleixner wrote:
> On Tue, 2 Aug 2016, Eric Auger wrote:
> 
>> Currently the MSI message is composed by directly calling
>> irq_chip_compose_msi_msg and erased by setting the memory to zero.
>>
>> On some platforms, we will need to complexify this composition to
>> properly handle MSI emission through IOMMU. Also we will need to track
>> when the MSI message is erased.
> 
> I just can't find how you do that. After applying the series the
> 
>> +	if (erase)
>> +		memset(msg, 0, sizeof(*msg));
> 
> branch is still just a memset(). The wrapper is fine for the compose side, but
> having the extra argument just to wrap the memset() for no gain is silly.

Yes you're right: this was true in the first releases of the series
where the iommu mapping/unmapping were done at composition & erase time.
Now the mapping/unmapping is done on msi_domain_alloc/free_irqs, this is
not mandated anymore. I will keep the wrapper for the compose side and
remove the rest + update the commit message accordingly.

Thank you for your time.

Eric
> 
> Thanks,
> 
> 	tglx
> --
> To unsubscribe from this list: send the line "unsubscribe kvm" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
