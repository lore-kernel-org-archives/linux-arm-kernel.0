From: slash.tmp@free.fr (Mason)
Date: Sat, 23 Jan 2016 12:14:38 +0100
Subject: Unhandled fault: page domain fault (0x81b) at 0x00e41008
In-Reply-To: <20160122235704.GF19062@n2100.arm.linux.org.uk>
References: <56A268E7.7040004@free.fr>
 <20160122174814.GD19062@n2100.arm.linux.org.uk> <56A27C00.5060004@free.fr>
 <20160122193408.GE19062@n2100.arm.linux.org.uk> <56A2B811.8010306@free.fr>
 <20160122235704.GF19062@n2100.arm.linux.org.uk>
Message-ID: <56A3609E.3000400@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 23/01/2016 00:57, Russell King - ARM Linux wrote:
> On Sat, Jan 23, 2016 at 12:15:29AM +0100, Mason wrote:
>> On 22/01/2016 20:34, Russell King - ARM Linux wrote:
>>> What do these "block_copy8, block_copy16, block_copy32" functions
>>> do?  Does the "8", "16" and "32" refer to the access size?  Why do
>>> they need to make accesses to userspace using these specific sizes?
>>> What causes this restriction?
>>
>> Interfaces are somewhat arbitrary. The problem statement
>> was as follows.
>>
>> Implement functions for copying a range of addresses
>> FROM user-space, TO physical addresses,
>> (and also the other way around)
>> in access size of 8, 16, 32 bits.
>>
>> So, a little over a decade ago, someone decided that these
>> functions would have the following prototype:
>>
>> int read_data8  (u8  *user_addr, u8  *phys_addr, int count)
>> int read_data16 (u16 *user_addr, u16 *phys_addr, int count)
>> int read_data32 (u32 *user_addr, u32 *phys_addr, int count)
>>
>> int write_data8 (u8  *user_addr, u8  *phys_addr, int count)
>> int write_data16(u16 *user_addr, u16 *phys_addr, int count)
>> int write_data32(u32 *user_addr, u32 *phys_addr, int count)
> 
> Of course, physical addresses are _integers_ and not pointers... (I can't
> help but say that because every time I see that mistake, I'm duty bound
> to educate to prevent anyone thinking this kind of thing is a good idea.)
> 
>> (Note: the following code is simplified, as count may be
>> larger than vmalloc space, so the operation needs to be
>> "chunked" or "tiled".)
>>
>> int read_data8 (u8 *user_addr, u8 *phys_addr, int count)
>> {
>>   int i, err = 0;
>>
>>   /* map phys_addr into kernel VA */
>>   void *va = ioremap(phys_addr, count);
>>   if (va == NULL) return some_error;
>>
>>   for (i = 0; i < count; ++i) {
>>     u8 val = readb(va + i);
>>     err = put_user(val, user_addr + i);
>>     if (err) break;
>>   }
>>
>>   iounmap(va);
>>   return err;
>> }
>>
>> Is this what you are suggesting?
>>
>> I expect this to be quite slow.
> 
> That probably will be quite slow.  How about this instead:
> 
> int read_data8(u8 __user *user_addr, phys_addr_t phys_addr, size_t bytes)
> {
> 	const size_t batch_size = PAGE_SIZE;
> 	void __user *user_pos = user_addr;
> 	void __iomem *va;
> 	size_t i, j;
> 	u8 *buf;
> 	int err;
> 
> 	va = ioremap(phys_addr, bytes);
> 	buf = kmalloc(batch_size);
> 	if (!va || !buf) {
> 		iounmap(va);
> 		kfree(buf);
> 		return -ENOMEM;
> 	}
> 
> 	for (i = 0; i < bytes; i += batch_size) {
> 		size_t len = bytes - i;
> 		if (len > batch_size)
> 			len = batch_size;
> 
> 		for (j = 0; j < len; j += sizeof(*buf))
> 			buf[j / sizeof(*buf)] = readb_relaxed(va + i + j);
> 
> 		if (copy_to_user(user_pos, buf, len)) {
> 			err = -EFAULT;
> 			break;
> 		}
> 
> 		user_pos += len;
> 	}
> 
> 	iounmap(va);
> 	kfree(buf);
> 	return err;
> }
> 
> You can change the batch size by altering the "batch_size" variable,
> though I suspect you'll find that the above may be reasonably fast.
> 
> You should only need to change the "u8" data types and the iomem
> accessor for your other read functions.

Russell,

Thanks for taking the time to walk me through it. I really
appreciate it. I'll benchmark on Monday.

One more thing: for the important use-case I described
(copying a file to remote RAM) the existing code was using
write_data8! Obvious optimization was to use write_data32
but this still means two unnecessary copies:

1) copying file contents to user-space temp buffer
2) copying user-space to temp kernel buffer
3) finally move data to remote RAM

I had a different approach which avoids the 2 copies:
In user-space, mmap the physical address using /dev/mem
and just use the read syscall to copy from filesystem
into remote RAM.

I don't need to worry about access size in that specific
instance (since I'm copying to RAM).

What do you think about that?

Regards.
