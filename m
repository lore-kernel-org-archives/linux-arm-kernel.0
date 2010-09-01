From: ryan@bluewatersys.com (Ryan Mallon)
Date: Thu, 02 Sep 2010 09:23:07 +1200
Subject: [PATCH 28/74] Incrementing the ecc_pos array to contain 128 char
In-Reply-To: <4C7E3344.2020202@st.com>
References: <07ce8daf18d3a9f13864752074af3490a324d84c.1283161023.git.viresh.kumar@st.com>		<a750eadbd743c3a2d5dc8b35c25e0ee82f569e87.1283161023.git.viresh.kumar@st.com>		<1283170469.12995.53.camel@brekeke>
	<4C7CA278.9040902@st.com>		<1283297810.2018.67.camel@brekeke>
	<4C7DD2FD.1080501@st.com>	<1283337939.1958.20.camel@brekeke>
	<4C7E3344.2020202@st.com>
Message-ID: <4C7EC43B.2050903@bluewatersys.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/01/2010 11:04 PM, Vipin Kumar wrote:
> On 9/1/2010 4:15 PM, Artem Bityutskiy wrote:
>> On Wed, 2010-09-01 at 09:43 +0530, Vipin Kumar wrote:
>>> On 9/1/2010 5:06 AM, Artem Bityutskiy wrote:
>>>> Hi,
>>>>
>>>> On Tue, 2010-08-31 at 12:04 +0530, Vipin Kumar wrote:
>>>>>> Nack, breaking ABI Is not allowed in Linux.
>>>>> I could not understand your point. Can you please elaborate. How does this patch 
>>>>> break ABI
>>>>
>>>> You are changing data structure (struct nand_ecclayout) used for in MTD
>>>> ioctl. Tha ioctl is part of the Linux ABI. By changing the data
>>>> structure, you are breaking the ABI. This means that current binaries
>>>> would stop working with newer versions of the Linux kernel if we'd
>>>> accept your patch.
>>>>
>>> Hello,
>>>
>>> The only change that I have made is increasing the number of bytes to keep ecc. 
>>
>> Right, but this break ABI.
>>
>>> Since the ecc is generally kept in spare area, it makes sense to have the ecc 
>>> locations to be equal to the maximum spare area possible.
>>
>> May be.
>>
>>> A NAND page with a page size of 4096 would contain a spare area of 128 bytes. 
>>> Now, ecc for the page can be less/more than 64 bytes(currently allocated for 
>>> ecc positions) depending on the algorithm used to generate ecc. 
>>> Incidently, in our case the ecc can fit in 104 bytes and this is still quite 
>>> logical to place it in spare area since the linux image supports 4096 page but 
>>> the problem is that the ecc locations supported by linux are less than the 
>>> practically possible scenario so in effect this change is an improvement in linux
>>
> 
> Hello David/Artem,
> 
> I got the point, but this change is essential (at least for me). It may be 
> essential to others as well in near future. Please let me know how to handle more 
> than 64 bytes of ecc
> 
>> Yes, this is historical and a bit unfortunate, but you cannot break ABI
>> even if you have reasons like that

We have run into this same problem using large page NAND chips. Our fix
in the past has been the same as presented here simply because it is
easy and for custom boards we do not care if we break the kernel ABI
since the kernel will only be used on our custom board.

However, we are interested in having a proper solution to this problem.
Basically the size of the eccpos array shouldn't be a fixed. Probably
there should be two ioctls, one to get the size of the eccpos array and
a second to get the actual array.

It is unfortunate that we already have the obsolete nand_oobinfo struct,
and any fix to this problem is probably going to obsolete the
nand_ecclayout struct, but we do need to fix this as the existing
infrastructure is not suitable for larger nand chips.

~Ryan

-- 
Bluewater Systems Ltd - ARM Technology Solution Centre

Ryan Mallon         		5 Amuri Park, 404 Barbadoes St
ryan at bluewatersys.com         	PO Box 13 889, Christchurch 8013
http://www.bluewatersys.com	New Zealand
Phone: +64 3 3779127		Freecall: Australia 1800 148 751
Fax:   +64 3 3779135			  USA 1800 261 2934
