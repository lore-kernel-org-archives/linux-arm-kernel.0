From: mchehab@redhat.com (Mauro Carvalho Chehab)
Date: Sat, 10 Dec 2011 09:13:06 -0200
Subject: [Linaro-mm-sig] [RFC v2 1/2] dma-buf: Introduce dma buffer sharing
 mechanism
In-Reply-To: <20111209225056.GL7969@morell.nvidia.com>
References: <1322816252-19955-1-git-send-email-sumit.semwal@ti.com>
 <1322816252-19955-2-git-send-email-sumit.semwal@ti.com>
 <201112051718.48324.arnd@arndb.de> <20111209225056.GL7969@morell.nvidia.com>
Message-ID: <4EE33EC2.6050508@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09-12-2011 20:50, Robert Morell wrote:
> On Mon, Dec 05, 2011 at 09:18:48AM -0800, Arnd Bergmann wrote:
>> On Friday 02 December 2011, Sumit Semwal wrote:
>>> This is the first step in defining a dma buffer sharing mechanism.
>>
> [...]
>>
>>> +	return dmabuf;
>>> +}
>>> +EXPORT_SYMBOL(dma_buf_export);
>>
>> I agree with Konrad, this should definitely be EXPORT_SYMBOL_GPL,
>> because it's really a low-level function that I would expect
>> to get used by in-kernel subsystems providing the feature to
>> users and having back-end drivers, but it's not the kind of thing
>> we want out-of-tree drivers to mess with.
>
> Is this really necessary?  If this is intended to be a
> lowest-common-denominator between many drivers to allow buffer sharing,
> it seems like it needs to be able to be usable by all drivers.
>
> If the interface is not accessible then I fear many drivers will be
> forced to continue to roll their own buffer sharing mechanisms (which is
> exactly what we're trying to avoid here, needless to say).

Doing a buffer sharing with something that is not GPL is not fun, as, if any
issue rises there, it would be impossible to discover if the problem is either
at the closed-source driver or at the open source one. At the time I was using
the Nvidia proprietary driver, it was very common to have unexplained issues
caused likely by bad code there at the buffer management code, causing X
applications and extensions (like xv) to break.

We should really make this EXPORT_SYMBOL_GPL(), in order to be able to latter
debug future share buffer issues, when needed.

Regards,
Mauro
