From: boris.brezillon@free-electrons.com (Boris BREZILLON)
Date: Thu, 01 May 2014 22:56:06 +0200
Subject: [RFC PATCH 0/3] mtd: nand: add randomizer support
In-Reply-To: <20140501175946.GA14539@obsidianresearch.com>
References: <1398906592-24677-1-git-send-email-b.brezillon.dev@gmail.com>
 <20140501163407.GB3296@obsidianresearch.com>
 <536284E1.50001@free-electrons.com>
 <20140501175946.GA14539@obsidianresearch.com>
Message-ID: <5362B4E6.7010009@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


On 01/05/2014 19:59, Jason Gunthorpe wrote:
> On Thu, May 01, 2014 at 07:31:13PM +0200, Boris BREZILLON wrote:
>
>> I totally agree with you, this is not a randomizer but rather a scrambler.
>> The reason I chose the "randomizer" word is that all the documents I
>> read are talking about randomizers.
>> But, other than I don't have any concern about changing all references
>> to "randomizer" into "scrambler" ;-).
> If nobody else says anything, Scrambler is at least consistent with
> Wikipedia..
>
> and 'descrambler' sounds better than 'unrandomizer' :)
>  
>>> BTW, there are security concerns here. The scrambler PRBS must not be
>>> predictable by the user, otherwise they can write data that undoes the
>>> scramble and defeat it, ie deliberately writing the last 2k of a 4k
>>> write block as all 0's after scrambling could cause the first 2k to be
>>> lost. That feels like something that could be scary ..
>> AFAICT, the scramblers/randomizers used in NAND applications are all
>> predictable, which means the scrambler state does not depend on the last
>> data being scrambled.
> Right, I'm not surprised storage would use a synchronous scrambler,
> self-synchronizing scramblers make the most sense for communication..
>
> However, with a synchronous scrambler the security concern boils down
> to how robust and unpredictable is the PRBS.

I'm not sure security is the main concern here.
AFAICT, NAND scramblers (note that I stopped using the name "randomizer"
:-)) is mainly used to avoid large island of identical data, because
some NAND chips are sensible to such patterns (see [1] page 14).

>
> For instance, re-using the same PRBS seed and staring point for every
> block is probably a bad idea.

The proposed solution leave the scrambling process to the scrambler
implementation, thus it is possible to provide a different seed for each
block.
And this is exactly what's done in the sunxi HW  scrambler
implementation, or at least you can do it based on what you're
specifying in your DT (see the "nand-randomizer-seeds" in the 3rd
patch): you can define a seed table and the seed is selected based on
the page number you're reading or writing.


>
> At the very least I would think the block number should be included in
> the per-block seed of the PRBS.
>
> And also a per-parition/device global seed..

Actually the seed table is configurable per-partition and this is why I
depend on the "per-partition ECC config" series.

Best Regards,

Boris

[1] http://www.bswd.com/FMS09/FMS09-T2A-Grunzke.pdf

-- 
Boris Brezillon, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
