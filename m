From: slash.tmp@free.fr (Mason)
Date: Wed, 27 Jan 2016 13:04:23 +0100
Subject: Unhandled fault: page domain fault (0x81b) at 0x00e41008
In-Reply-To: <20160127104811.GX10826@n2100.arm.linux.org.uk>
References: <56A27C00.5060004@free.fr>
 <20160122193408.GE19062@n2100.arm.linux.org.uk> <56A2B811.8010306@free.fr>
 <20160122235704.GF19062@n2100.arm.linux.org.uk> <56A3609E.3000400@free.fr>
 <20160123113438.GG19062@n2100.arm.linux.org.uk> <56A3E84A.1000604@free.fr>
 <20160123235905.GE10826@n2100.arm.linux.org.uk> <56A4D13D.3030906@free.fr>
 <56A89DC3.8010309@free.fr> <20160127104811.GX10826@n2100.arm.linux.org.uk>
Message-ID: <56A8B247.50002@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 27/01/2016 11:48, Russell King - ARM Linux wrote:

> Mason wrote:
> 
>> IIUC, Arnd mentioned that there might be an issue using readl_relaxed
>> on a memory region with a big-endian kernel.
> 
> I think you're confused there, or Arnd's comment was incorrect.

I have certainly misunderstood Arnd's comment.

> In any case, I'm even more pissed off with you.  Let me quote from
> your earlier emails:
> 
>> The problem is that the kernel module's API is already set
>> in stone, and it requires block copies with specific access
>> sizes, e.g. block_copy8, block_copy16, block_copy32.
> 
> and:
> 
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
> However, you've done away with those prototypes, and instead come up
> with something that looks like:
> 
> int block_copy(void __user *ua, phys_addr_t pa, size_t bytes, fun_t *fun)
> 
> ?
> 
> So, let me get this straight.  You demand that the API can't be changed,
> and I provide you with a solution which results in very little change to
> the API.

I don't understand what is unclear in my description.

The user-space API to call into the kernel module is, and has always been:

	int read_data8  (u8 *user_addr,  u32 phys_addr, int count)
	int read_data16 (u16 *user_addr, u32 phys_addr, int count)
	int read_data32 (u32 *user_addr, u32 phys_addr, int count)

	int write_data8 (u8 *user_addr,  u32 phys_addr, int count)
	int write_data16(u16 *user_addr, u32 phys_addr, int count)
	int write_data32(u32 *user_addr, u32 phys_addr, int count)

A user-space shim shoves the parameters inside a struct and calls into
the kernel module via ioctl. The ioctl dispatcher then unpacks the
parameters and calls block_copy:

	case DIRECT_IOCTL_READ_DATA32:
	{
		struct data32 s;
		if (copy_from_user(&s, (void *)arg, sizeof s)) break;
		rc = block_copy(s.data, s.byte_address, s.count*4, read32);
		break;
	}

> However, rather than testing the version I carefully created for you,
> you've decided that you're not going to, instead coming up with your
> own solution which breaks all your previous demands.

Why do you say that my solution breaks my previous demands?

Note that block_copy is directly inspired from your read_data8 example.
The prototypes are nearly identical:

int block_copy(void __user *ua, phys_addr_t pa, size_t bytes, fun_t *fun)
int read_data8(u8 __user *user_addr, phys_addr_t phys_addr, size_t bytes)

I just added the function pointer to be able to generalize the function
for 16-bit and 32-bit accesses.

By the way, thanks again for providing read_data8, it really helped me
get a better grasp of the process.

I don't understand what it is you found so blatantly outrageous in my
message? Perhaps I need to improve my writing skills.

> This is totally rediculous.  Why should I waste any more time with _any_
> of your questions?

All I can say is that I am grateful for the help you've provided so far,
and I will try to be clearer in my problem descriptions in the future.

Regards.
