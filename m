From: ddaney@caviumnetworks.com (David Daney)
Date: Thu, 25 Feb 2016 17:26:34 -0800
Subject: [PATCH v11 08/10] dt, numa: Add NUMA dt binding implementation.
In-Reply-To: <20160223193651.GA8491@rob-hp-laptop>
References: <1455930799-5371-1-git-send-email-ddaney.cavm@gmail.com>
 <1455930799-5371-9-git-send-email-ddaney.cavm@gmail.com>
 <20160223193651.GA8491@rob-hp-laptop>
Message-ID: <56CFA9CA.6090803@caviumnetworks.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/23/2016 11:36 AM, Rob Herring wrote:
> On Fri, Feb 19, 2016 at 05:13:17PM -0800, David Daney wrote:
>> From: Ganapatrao Kulkarni <gkulkarni@caviumnetworks.com>
>>
>> ADD device tree node parsing for NUMA topology using device
>> "numa-node-id" property distance-map.
>
> I still want an adequate explanation why NUMA setup cannot be done with
> an unflattened tree. PowerPC manages to do that and should have a
> similar init flow being memblock based, so I would expect arm64 can too.

Many things could be done.  Really, we want to know what *should* be done.

In the context of the current arm64 memory initialization we (more or 
less) do:

  1) early_init_fdt_scan_reserved_mem();
  2) memory_present()
  3) sparse_init()
  4) other things
  5) unflatten_device_tree()

We are already reading information out of the FDT at #1.

This patch set adds a step between 1 and 2 where we read NUMA 
information out of the FDT.

Hypothetically, it might be possible to rewrite the arm64 setup code so 
that the ordering was different, and the NUMA setup was done on the 
unflattened tree, but that would certainly be a much more invasive patch.

If the arm64 maintainers would like a rewrite of:

   arch/arm64/kernel/setup.c
   arch/arm64/mm/init.c
   arch/arm64/mm/mm/mmu.c
   .
   .
   .

we can discuss doing NUMA setup with the unflattened tree.  With the 
current memory initialization code, I think it makes more sense to parse 
the NUMA information out of the flattened form.

David Daney
