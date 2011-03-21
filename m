From: bones@secretlab.ca (John Bonesio)
Date: Mon, 21 Mar 2011 11:36:56 -0700
Subject: [PATCH] ARM:boot:device tree: Allow the device tree binary to
	be appended to zImage
In-Reply-To: <alpine.LFD.2.00.1103211413560.11889@xanadu.home>
References: <20110309215800.26377.43925.stgit@riker>
	<alpine.LFD.2.00.1103171422500.26889@xanadu.home>
	<4D878C63.6080205@secretlab.ca>
	<alpine.LFD.2.00.1103211413560.11889@xanadu.home>
Message-ID: <4D879AC8.9080901@secretlab.ca>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Comments below.

- John

On 03/21/2011 11:22 AM, Nicolas Pitre wrote:
> On Mon, 21 Mar 2011, John Bonesio wrote:
> 
>> Hi Nicolas,
>>
>> Thanks for the comments. I have a question (below).
>>
> [...]

[snip]

>>>
>>> Now if no dtb was found, or if that code is not configured, then lr 
>>> contains garbage and that may have random consequences with the code 
>>> that follows, which would explain the reported bad behaviors with this 
>>> patch applied even if not configured in the kernel.
>>
>> I'm probably not understanding something here. When I look at the code
>> prior to my patch, it looks like lr is not initialized by head.S.
> 
> Exact.
> 
>> It also looks like this code makes use of lr when it relocates the 
>> code and leaves it uninitialized when it jumps back to 'restart'.
> 
> Exact.
> 
>> Is this a bug in the previous code too?
> 
> No.
> 
>> What should lr be initialized to, or should we just be preserving it's
>> value?
> 
> No.  The problem is that you do use lr further down in your patch when 
> adjusting GOT entries, assuming it contains the size of the dtb.  If no 
> DTB is found then lr contains random stuff that will mess up the GOT for 
> .bss references.

Oh! Good catch. Thanks.

> 
>> I saw the comment about the performance is different with this patch -
>> something about a pause between 'Uncompressing Linux...' and the kernel
>> boot output. I'm not sure what's going on here. By the time
>> 'Uncompressing Linux...' comes out all relocations and dtb discovery is
>> complete. Do you really think having lr uninitialized would cause this?
> 
> Certainly.  See above.
> 
> 
> Nicolas
