From: julien.grall@arm.com (Julien Grall)
Date: Thu, 18 Oct 2018 14:52:07 +0100
Subject: [KVMTOOL][PATCH v2 3/9] virtio/scsi: Allow to use multiple banks
In-Reply-To: <86093494-1ba0-6f72-06d2-a69a9636d59c@arm.com>
References: <20181018133748.32577-1-julien.grall@arm.com>
 <20181018133748.32577-4-julien.grall@arm.com>
 <86093494-1ba0-6f72-06d2-a69a9636d59c@arm.com>
Message-ID: <8f15095f-4305-61cc-1524-ff18b00b4522@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 18/10/2018 14:47, Suzuki K Poulose wrote:
> 
> Hi Julien,

Hi Suzuki,

> On 10/18/2018 02:37 PM, Julien Grall wrote:
>> At the moment, virtio scsi only register a bank starting at 0. On some
>> architectures this may not be true and the guest may have multiple
>> memory region.
>>
>> Register all the memory regions to vhost by browsing kvm->mem_banks. The
>> code is based on the virtio_net__vhost_init implementation.
>>
>> Signed-off-by: Julien Grall <julien.grall@arm.com>
>>
>> ---
>>
>> This code was not tested as I don't have any setup with scsi.
>> ---
>> ? virtio/scsi.c | 21 +++++++++++++--------
>> ? 1 file changed, 13 insertions(+), 8 deletions(-)
>>
>> diff --git a/virtio/scsi.c b/virtio/scsi.c
>> index a429ac8..0361285 100644
>> --- a/virtio/scsi.c
>> +++ b/virtio/scsi.c
>> @@ -178,24 +178,29 @@ static struct virtio_ops scsi_dev_virtio_ops = {
>> ? static void virtio_scsi_vhost_init(struct kvm *kvm, struct scsi_dev 
>> *sdev)
>> ? {
>> +??? struct kvm_mem_bank *bank;
>> ????? struct vhost_memory *mem;
>> ????? u64 features;
>> -??? int r;
>> +??? int r, i;
>> ????? sdev->vhost_fd = open("/dev/vhost-scsi", O_RDWR);
>> ????? if (sdev->vhost_fd < 0)
>> ????????? die_perror("Failed openning vhost-scsi device");
>> -??? mem = calloc(1, sizeof(*mem) + sizeof(struct vhost_memory_region));
>> +??? mem = calloc(1, sizeof(*mem) + kvm->mem_slots * sizeof(struct 
>> vhost_memory_region));
>> ????? if (mem == NULL)
>> ????????? die("Failed allocating memory for vhost memory map");
>> -??? mem->nregions = 1;
>> -??? mem->regions[0] = (struct vhost_memory_region) {
>> -??????? .guest_phys_addr??? = 0,
>> -??????? .memory_size??????? = kvm->ram_size,
>> -??????? .userspace_addr??????? = (unsigned long)kvm->ram_start,
>> -??? };
>> +??? i = 0;
>> +??? list_for_each_entry(bank, &kvm->mem_banks, list) {
>> +??????? mem->regions[0] = (struct vhost_memory_region) {
>> +??????????? .guest_phys_addr??? = bank->guest_phys_addr,
>> +??????????? .memory_size??????? = bank->size,
>> +??????????? .userspace_addr??????? = (unsigned long)bank->host_addr,
>> +??????? };
>> +
>> +??? }
>> +??? mem->nregions = i;
> 
> That looks wrong. We set mem->nregions to 0 ?
> Or did you miss an "i++" inside the loop ?

I missed the "i++" inside the loop. Good catch!
I will fix it in the next version.

Cheers,

-- 
Julien Grall
