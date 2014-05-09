From: ezequiel.garcia@free-electrons.com (Ezequiel Garcia)
Date: Fri, 9 May 2014 19:09:15 -0300
Subject: [PATCH 2/2] mtd: orion-nand: fix build error with ARMv4
In-Reply-To: <20140509212810.GF18257@obsidianresearch.com>
References: <1399560433-1402630-1-git-send-email-arnd@arndb.de>
 <1399560990-1402858-1-git-send-email-arnd@arndb.de>
 <1399560990-1402858-4-git-send-email-arnd@arndb.de>
 <20140509184505.GA30330@arch.cereza>
 <20140509212810.GF18257@obsidianresearch.com>
Message-ID: <20140509220915.GA391@arch.cereza>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09 May 03:28 PM, Jason Gunthorpe wrote:
> 
> > I gave this a try in order to answer Arnd's performance
> > question. First of all, the patch seems wrong. I guess it's because
> > readsl reads 4-bytes pieces, instead of 8-bytes.
> > 
> > This patch below is tested (but not completely, see below) and works:
> 
> Compilers are better now, I think you can just ditch the weirdness:
> 
[..]
> 
> The below gives:
> 
>   c8:   ea000002        b       d8 <orion_nand_read_buf+0x84>
>   cc:   e5dc0000        ldrb    r0, [ip]
>   d0:   e7c30001        strb    r0, [r3, r1]
>   d4:   e2811001        add     r1, r1, #1
>   d8:   e1510002        cmp     r1, r2
> 
> Which looks the same as the asm version to me.
> 

Nice! It wasn't really needed but since I have the board here:

# time nanddump /dev/mtd5 -f /dev/null -q
real	0m 5.82s
user	0m 0.20s
sys	0m 5.60s

Jason: Care to submit a proper patch?

On 08 May 04:56 PM, Arnd Bergmann wrote:
> Ok, that is a noticeable difference. For scale, what is the size of that partition?

The board is Openblocks A6, running mainline.

# cat /proc/mtd 
dev:    size   erasesize  name
mtd0: 00090000 00004000 "uboot"
mtd1: 00044000 00004000 "env"
mtd2: 00024000 00004000 "test"
mtd3: 00400000 00004000 "conf"
mtd4: 01d20000 00004000 "linux"
mtd5: 01dec000 00004000 "user"

-- 
Ezequiel Garc?a, Free Electrons
Embedded Linux, Kernel and Android Engineering
http://free-electrons.com
