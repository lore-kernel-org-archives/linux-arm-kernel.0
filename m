From: slash.tmp@free.fr (Mason)
Date: Sat, 23 Jan 2016 00:15:29 +0100
Subject: Unhandled fault: page domain fault (0x81b) at 0x00e41008
In-Reply-To: <20160122193408.GE19062@n2100.arm.linux.org.uk>
References: <56A268E7.7040004@free.fr>
 <20160122174814.GD19062@n2100.arm.linux.org.uk> <56A27C00.5060004@free.fr>
 <20160122193408.GE19062@n2100.arm.linux.org.uk>
Message-ID: <56A2B811.8010306@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 22/01/2016 20:34, Russell King - ARM Linux wrote:

> It's possible to use access_ok() + __copy_from_user(), but that's
> really frowned upon because it's _very_ easy to get it wrong - and
> then you have a security bug.

I was following advice from LDD3.

>>> Drivers and platform code should use copy_from_user()/copy_to_user()
>>> to block-copy data to/from userspace, and get_user()/put_user() to
>>> copy individual bytes, shorts and int/longs.  (It doesn't matter
>>> who you are, that's the official guidance.)
>>
>> The problem is that the kernel module's API is already set
>> in stone, and it requires block copies with specific access
>> sizes, e.g. block_copy8, block_copy16, block_copy32.
> 
> Rather than making these statements, you need to explain what, how
> and why.
> 
> What do these "block_copy8, block_copy16, block_copy32" functions
> do?  Does the "8", "16" and "32" refer to the access size?  Why do
> they need to make accesses to userspace using these specific sizes?
> What causes this restriction?

Interfaces are somewhat arbitrary. The problem statement
was as follows.

Implement functions for copying a range of addresses
FROM user-space, TO physical addresses,
(and also the other way around)
in access size of 8, 16, 32 bits.

So, a little over a decade ago, someone decided that these
functions would have the following prototype:

int read_data8  (u8  *user_addr, u8  *phys_addr, int count)
int read_data16 (u16 *user_addr, u16 *phys_addr, int count)
int read_data32 (u32 *user_addr, u32 *phys_addr, int count)

int write_data8 (u8  *user_addr, u8  *phys_addr, int count)
int write_data16(u16 *user_addr, u16 *phys_addr, int count)
int write_data32(u32 *user_addr, u32 *phys_addr, int count)


IIUC what you're saying, the only 100% correct solution
would be something like this:

(Note: the following code is simplified, as count may be
larger than vmalloc space, so the operation needs to be
"chunked" or "tiled".)

int read_data8 (u8 *user_addr, u8 *phys_addr, int count)
{
  int i, err = 0;

  /* map phys_addr into kernel VA */
  void *va = ioremap(phys_addr, count);
  if (va == NULL) return some_error;

  for (i = 0; i < count; ++i) {
    u8 val = readb(va + i);
    err = put_user(val, user_addr + i);
    if (err) break;
  }

  iounmap(va);
  return err;
}

Is this what you are suggesting?

I expect this to be quite slow.

The problem is that one important user of the API is a
program used to copy the contents of files to "remote"
RAM, i.e. RAM not managed by Linux, to pass that
information to a secure processor, which then copies
it to the DSPs. And this operation is on the critical
path (at boot-time) and must be as fast as possible.

Regards.
