From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 29 Mar 2012 07:53:04 +0000
Subject: [PATCH V2 5/7] ARM: SPEAr3xx: Add device-tree support to SPEAr3xx
 architecture
In-Reply-To: <4F740386.2080509@st.com>
References: <cover.1332926608.git.viresh.kumar@st.com>
 <201203281227.32299.arnd@arndb.de> <4F740386.2080509@st.com>
Message-ID: <201203290753.04758.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 29 March 2012, Viresh Kumar wrote:
> But there are few concerns.
> Firstly, i wasn't aware that ioremap will reuse these mappings.
> I believed that it will create new mappings and this is what i
> saw till 2-6.37. What will happen if iounmap is called?

Yes, it was a fairly recent change. iounmap on one of these areas
will do nothing.

> Over that, board would not be using all the devices present in SoC. So,
> we don't really need to map everything. And so above wouldn't be valid
> there.

That should not really be a concern, you only waste a little bit of
the vmalloc space that you gained recently when ioremap was changed.
Nothing should ever be able to get to those pointers other than by
calling ioremap, so it doesn't hurt to have them mapped, except for
the very unlikely scenario that you get a wild pointer dereference
in the kernel that would otherwise result in an oops.

> To avoid holes, that were created in my original mappings, i can pick your
> idea of dropping IO_ADDRESS() in .virtual field and use tightly aligned
> virtual address for all peripherals.
> 
> Like: UART - 4K - 0xf0000000 - 0xf0001000
>       SPI - 4K -  0xf0001000 - 0xf0002000

Well, if you use the 4k mappings here, you won't benefit from reduced
TLB pressure through section maps, although you still get rid of IO_ADDRESS.
I would not put any devices into the static mapping, other than those
you need to access before mm_init() or when you can actually use the section
mapping.

	Arnd
