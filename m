From: slash.tmp@free.fr (Mason)
Date: Fri, 22 Jan 2016 19:59:12 +0100
Subject: Unhandled fault: page domain fault (0x81b) at 0x00e41008
In-Reply-To: <20160122174814.GD19062@n2100.arm.linux.org.uk>
References: <56A268E7.7040004@free.fr>
 <20160122174814.GD19062@n2100.arm.linux.org.uk>
Message-ID: <56A27C00.5060004@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 22/01/2016 18:48, Russell King - ARM Linux wrote:

> On Fri, Jan 22, 2016 at 06:37:43PM +0100, Mason wrote:
>
>> I'm hitting
>> Unhandled fault: page domain fault (0x81b) at 0x00e41008
>>
>> which is related to CPU_SW_DOMAIN_PAN
>> commit a5e090acbf545c0a3b04080f8a488b17ec41fe02
>>
>>
>> I see that __copy_from_user() is now wrapped in
>> uaccess_save_and_enable ... uaccess_restore
>>
>> I'm not using __copy_from_user() because I'm implementing block
>> copies with specific access size.
>>
>> Can I just wrap my block copy functions in
>> uaccess_save_and_enable ... uaccess_restore
>> like __copy_from_user?
> 
> No, you _must_ use the correct functions to access userspace.
> Userspace accesses are marked in a special way that allows the kernel
> to fix up non-present pages.

Do you mean calling might_fault() ?

> Normal accesses may appear to work but
> will eventually oops the kernel when the page is unmapped or is marked
> read-only and you try to write to it.

I'll have to check again how the code was before I made
my silly changes, but it's been in production for years,
and we've never had any problem in that module...
(But I suppose something broken can appear to work for
months or years.)

> Please don't think of using __copy_from_user() et.al. either - those
> are there for code which knows what it's doing and has pre-validated
> the accesses.

I do call access_ok() before doing the copy.

> Drivers and platform code should use copy_from_user()/copy_to_user()
> to block-copy data to/from userspace, and get_user()/put_user() to
> copy individual bytes, shorts and int/longs.  (It doesn't matter
> who you are, that's the official guidance.)

The problem is that the kernel module's API is already set
in stone, and it requires block copies with specific access
sizes, e.g. block_copy8, block_copy16, block_copy32.

So copy_to/from_user is out, AFAICT.

Marc Zyngier suggested wrapping put/get_user in a loop,
but it looks like performance is going to suck for large
copies (500-2000 KB)

Regards.
