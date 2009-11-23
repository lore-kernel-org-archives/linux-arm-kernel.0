From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 23 Nov 2009 20:06:20 +0000
Subject: CAS implementation may be broken
In-Reply-To: <4B0ADE3B.3040307@45mercystreet.com>
References: <4AF1C361.8090405@45mercystreet.com>
	<20091104190544.GA518@n2100.arm.linux.org.uk>
	<4AF1FBA4.4070307@xenomai.org> <4B08055C.3000408@45mercystreet.com>
	<20091123150842.GD18142@n2100.arm.linux.org.uk>
	<4B0ADE3B.3040307@45mercystreet.com>
Message-ID: <20091123200620.GF18142@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 23, 2009 at 08:10:51PM +0100, Toby Douglass wrote:
> Russell King - ARM Linux wrote:
>> First time around the loop, lets say %3 = 1 *(u32 *)%2 = 1.
>>
>> 	ldrex	%1, [%2]
>> 				%1 = *(u32 *)%2 (= 1)
>> 	mov	%0, #0
>> 				%0 = 0
>> 	teq	%1, %3
>> 				%3 == %1? (yes)
>> 	strexeq	%0, %4, [%2]
>> 				executed but because of the other access,
>> 				exclusivity fails. *(u32 *)%2 not written
>> 				and %0 = 1
>>
>> So, res = 1, and we go around the loop again.  Lets say that *(u32 *)%2 = 2
>> now.
>
> No - we're dealing with the ABA problem.  We're assuming here that this  
> thread gets to retry with the same values.
>
>> I haven't had time to read all your email properly (due to the need to
>> get on a conference call), but please tell me where the problem is above
>> (using a similar worked example).
>
> So; we go around again, load %2, do the teq, which succeeds, then the  
> strexeq, which now succeeds since no-one else has touched %2.
>
> This was the thrust of the original post; however, Catalin has raised  
> arguments against it which I have not yet digested, so what I'm writing  
> here, where it is simply an enlargement on the OP, has the same flaws;  
> it's only in response to your specific point.  I'm not trying to assert  
> this *is* what happens, in spite of what Catalin has written.

Well, I've thought it through quite a bit now, and I have an expansive
reply to your email.  In summary, there is nothing wrong with the
existing code; your use of it is the problem.

I can post the expansive reply if you need the details.

In short, consider what happens if you consider a slightly different order
of operations, where you have calculated 'ptr', 'old' and 'new' for cmpxchg
but you haven't executed the first ldrex.
