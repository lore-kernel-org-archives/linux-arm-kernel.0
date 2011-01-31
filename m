From: therealbadguy@gmail.com (Chris)
Date: Sun, 30 Jan 2011 22:08:02 -0700
Subject: iMX31 MBX registers Porting problem
In-Reply-To: <20110131003128.GD27436@n2100.arm.linux.org.uk>
References: <AANLkTin+Mo9YXEfoDAa+btjX5VdiOz1QJp++ck0efPAk@mail.gmail.com>
	<20110131003128.GD27436@n2100.arm.linux.org.uk>
Message-ID: <AANLkTi=EsCCwgiK5BtkKfaYEuzVUtnie-LU77cNJ4P4q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Jan 30, 2011 at 5:31 PM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> On Sat, Jan 29, 2011 at 11:48:54PM -0700, Badguy Badguy wrote:
>> 2.6.35
>> 2.6.38-rc2
>> ?neither of these worked, provide various dynamic address results for
>> the registers,
>> Address: 0xC48C0000
>> MBX1_GLOBREG_REVISION: 0x00000000
>>
>> ?I have been trying to understand the code behind ioremap, and the
>> changes involved.
>
> I can't say why you can't access the registers, but as far as the above
> goes, please check /proc/vmallocinfo after each insert and remove, and
> report anything which looks wrong.

Ok, I did that and it inserts and removes an entry I am not sure about
what would be wrong.

0x7f000000-0x7f002000    8192 module_alloc_update_bounds+0x18/0x68
pages=1 vmalloc
...
0x848a0000-0x848a5000   20480 reg_probe+0x94/0x12c [reg] ioremap

0x7f006000-0x7f008000    8192 module_alloc_update_bounds+0x18/0x68
pages=1 vmalloc
...
0x848a8000-0x848ad000   20480 reg_probe+0x94/0x12c [reg] ioremap

here are two insertions, also showing the module bounds update, not
sure what to make of this information.

when I cat /proc/iomem I can see my entry:
   c0000000-c0003fff : mx3_mbx_regs.0

how can I know that the mapping is pointing me to my location?

>
> You should see a new entry when you insert, and that entry removed when
> you remove your module. ?Check that you're calling iounmap() with the
> right arguments too.
>

I do see the insertion and removal of a given entry when adding it,
also the one for the module wrapper.

when I read it on 2.6.19.2 it works, I have removed practically all
drivers and am left with
platform code and some serial support and it still works there.

I think I just have no confidence it has returned my requested location.
If I can get confirmation of that somehow it would be easier to move
on and look elsewhere.

> It might help if you posted a cut-down version of your code which just
> demonstrates the problem so others with an iMX31 can try it too.

I have attached a small file that I am using to example this problem.
I have no idea, what to do next here, so I am going to scour the 2.6.19.2 code
looking for something that might be turning this chip on. maybe iomux
has enabled it somewhere.

what about the amba interface? should i be using that to access this device?

http://infocenter.arm.com/help/index.jsp?topic=/com.arm.doc.ddi0277f/Cjacbdbd.html

are these the same thing? is this amba code found in the kernel going
to operate this device?

Thanks for your suggestions, I will continue looking.
I want to see fast graphics on the iMX on 2.6.38-rc2 :)
-------------- next part --------------
A non-text attachment was scrubbed...
Name: reg.c
Type: text/x-csrc
Size: 3366 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20110130/16eba3ea/attachment.bin>
