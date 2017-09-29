From: volodymyr_babchuk@epam.com (Volodymyr Babchuk)
Date: Fri, 29 Sep 2017 13:51:05 +0300
Subject: [PATCH v1 00/14] tee: optee: add dynamic shared memory support
In-Reply-To: <20170929103149.GB5781@leverpostej>
References: <1506621851-6929-1-git-send-email-volodymyr_babchuk@epam.com>
 <20170929103149.GB5781@leverpostej>
Message-ID: <02a5066a-b35a-1300-7c92-217f62efe3a2@epam.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Mark,

On 29.09.17 13:31, Mark Rutland wrote:
> Hi,
> 
> On Thu, Sep 28, 2017 at 09:03:57PM +0300, Volodymyr Babchuk wrote:
>> From: Volodymyr Babchuk <vlad.babchuk@gmail.com>
>>
>> This patch series enables dynamic shared memory support in the TEE
>> subsystem as a whole and in OP-TEE in particular.
>>
>> Global Platform TEE specification [1] allows client applications
>> to register part of own memory as a shared buffer between
>> application and TEE. This allows fast zero-copy communication between
>> TEE and REE. But current implementation of TEE in Linux does not support
>> this feature.
>>
>> Also, current implementation of OP-TEE transport uses fixed size
>> pre-shared buffer for all communications with OP-TEE OS. This is okay
>> in the most use cases. But this prevents use of OP-TEE in virtualized
>> environments, because:
>>   a) We can't share the same buffer between different virtual machines
>>   b) Physically contiguous memory as seen by VM can be non-contiguous
>>      in reality (and as seen by OP-TEE OS) due to second stage of
>>      MMU translation.
>>   c) Size of this pre-shared buffer is limited.
> 
> I'm afraid that I don't follow the arguments for virtualized OP-TEE
> usage.
Yes, this is short summary. This is patches for Linux kernel, so I 
thought it is okay to mention only linux part.

> In a virtualised environment, TEE access *must* be mediated via the
> hypervisor, which can virtualise the interface, pin pages, etc.
Absolutely right. I had many discussions with XEN community on this 
topic there: [2]
Also I had discussions with OP-TEE guys there: [3]

> Could you elaborate on how you expect TEE access to work in a
> virtualised environment?
Hypervisor will trap all SMCs. SMCs that belong to TEE OS and TEE apps 
will be handled by corresponding TEE mediator in a hypervsior.

TEE mediator will:

1) check if this guest/domain have right to work with TEE at all.
2) Mangle pointers in command buffer (translate IPA to PA)
3) Add VMID to request
3) Forward mangled request to TEE
4) Mangle pointers in response buffer (if any)
5) Return response back to guest.

Besides this, TEE mediator will inform TEE about guest creation and 
destruction, so TEE can track opened sessions, shared buffers and such.

[2] http://xen.markmail.org/thread/6pwpa2j6sbqkxgge
[3] https://github.com/OP-TEE/optee_os/issues/1019
