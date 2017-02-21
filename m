From: marc_gonzalez@sigmadesigns.com (Marc Gonzalez)
Date: Tue, 21 Feb 2017 13:02:48 +0100
Subject: [RESEND PATCH 1/3] mtd: nand: Pass the CS line to
 ->setup_data_interface()
In-Reply-To: <20170221120648.19e0d32c@bbrezillon>
References: <1487625149-7234-1-git-send-email-boris.brezillon@free-electrons.com>
 <1487625149-7234-2-git-send-email-boris.brezillon@free-electrons.com>
 <a5a9d822-a73c-4fd1-201c-7a17d9517f24@sigmadesigns.com>
 <20170221120648.19e0d32c@bbrezillon>
Message-ID: <45a843fb-c43e-711f-ce3a-4c0d44c48144@sigmadesigns.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 21/02/2017 12:06, Boris Brezillon wrote:

> Marc Gonzalez wrote:
> 
>> On 20/02/2017 22:12, Boris Brezillon wrote:
>>
>>> Some NAND controllers can assign different NAND timings to different
>>> CS lines. Pass the CS line information to ->setup_data_interface() so
>>> that the NAND controller driver knows which CS line is concerned by
>>> the setup_data_interface() request.  
>>
>> I'm confused, because I thought I was already doing that.
>> On my platform, I have different timings for each chip.
>> (thus, for each CS, right?)
>>
>> In chip->select_chip, I program the appropriate timings
>> which the controller will be using.
>>
>> What am I missing?
> 
> Maybe you don't have multi-dies chips, which is the case I'm fixing
> here. If you have 2 separate chips, the existing hook should work just
> fine.

Right. You asked me to add an explicit:

	res = of_property_count_u32_elems(np, "reg");
	if (res < 0)
		return res;

	if (res != 1)
		return -ENOTSUPP; /* Multi-CS chips are not supported */

I was under the impression that multi-die chips are seen as a single
larger "composite" chip. And I had assumed that different dies would
not only require identical timings, but would also be identical in
all other aspects. This it incorrect?

Regards.
