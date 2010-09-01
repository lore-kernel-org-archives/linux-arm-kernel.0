From: ryan@bluewatersys.com (Ryan Mallon)
Date: Thu, 02 Sep 2010 11:37:11 +1200
Subject: [PATCH 28/74] Incrementing the ecc_pos array to contain 128 char
In-Reply-To: <1283381602.2209.49.camel@brekeke>
References: <07ce8daf18d3a9f13864752074af3490a324d84c.1283161023.git.viresh.kumar@st.com>	
	<a750eadbd743c3a2d5dc8b35c25e0ee82f569e87.1283161023.git.viresh.kumar@st.com>	
	<1283170469.12995.53.camel@brekeke>	<4C7CA278.9040902@st.com>	
	<1283297810.2018.67.camel@brekeke>	<4C7DD2FD.1080501@st.com>	
	<1283337939.1958.20.camel@brekeke>	<4C7E3344.2020202@st.com>	
	<4C7EC43B.2050903@bluewatersys.com>	
	<AANLkTinmEck5413ZuCDMB1jyBjH63Uh=L+87q8V4Ek1X@mail.gmail.com>	
	<4C7ED1E9.4050208@bluewatersys.com>
	<1283381602.2209.49.camel@brekeke>
Message-ID: <4C7EE3A7.4050108@bluewatersys.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/02/2010 10:53 AM, Artem Bityutskiy wrote:
> On Thu, 2010-09-02 at 10:21 +1200, Ryan Mallon wrote:
>> On 09/02/2010 09:54 AM, Kevin Cernekee wrote:
>>> On Wed, Sep 1, 2010 at 2:23 PM, Ryan Mallon <ryan@bluewatersys.com> wrote:
>>>> However, we are interested in having a proper solution to this problem.
>>>
>>> I would suggest using this patch as a starting point - could you
>>> please review the changes and try it out?
>>>
>>> http://git.infradead.org/users/dedekind/l2-mtd-2.6.git/commitdiff/b6d6ae730be2750fac166ed9df11ee6ea54d9160
>>
>> That patch still breaks the ABI by renaming struct nand_ecclayout to
>> nand_ecclayout_user.
> 
> Hmm, would you please show why my binary file 'nandwrite' would have to
> be re-built?
> 
>>  Any application using the old names will have to be
>> rewritten to compile against a new kernel.
> 
> Not necessary. mtd-utils, for example, maintain their own copy of the
> mtd-abi.h file, which I personally think is a good idea.
> 
> But if your apps depend on the kernel headers, then yes, you will need
> to amend it or copy the old header into your project.
> 
> IOW, the patch breaks API by renaming, but not ABI, I think. I do not
> see this as a major problem - just a small inconvenience.

Sorry, you are correct, it breaks the API not the ABI. I understood that
such changes were still to be avoided.

>> The old interface should remain unchanged in that include/mtd/mtd-abi.h.
>> If an application using the old interface calls any of the ecc ioctls
>> for a nand chip with > 64 bytes ecc it should return an error.
> 
> It will, because size of the structure is part of the ioctl number,
> even. See the corresponding ioctl macro definition.

Right, but I don't think it needs the complexity of the shrink_ecc
function from Kevin's patch. The old ioctl should return an error
(possibly with a kernel message) if the requested nand chip has > 64
bytes ecc. Otherwise it should just copy upto 64 bytes into the old
nand_ecclayout structure and return.

Any new structure should be totally independent and should, IMHO, have
an arbitrary sized array for the ecc. It should have its own new set of
ioctls, one for getting the size of the ecc and one for getting the
actual ecc data. Though I can't remember if ioctls support arbitrary
sized arguments to make this possible.

~Ryan

-- 
Bluewater Systems Ltd - ARM Technology Solution Centre

Ryan Mallon         		5 Amuri Park, 404 Barbadoes St
ryan at bluewatersys.com         	PO Box 13 889, Christchurch 8013
http://www.bluewatersys.com	New Zealand
Phone: +64 3 3779127		Freecall: Australia 1800 148 751
Fax:   +64 3 3779135			  USA 1800 261 2934
