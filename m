From: wd@denx.de (Wolfgang Denk)
Date: Fri, 03 Aug 2012 17:06:02 +0200
Subject: MMAP_MIN_ADDR problem/question
In-Reply-To: <201208020939.50225.marek.vasut@gmail.com>
References: <201208020939.50225.marek.vasut@gmail.com>
Message-ID: <20120803150602.687DF203B3D@gemini.denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Wolfram,

In message <201208020939.50225.marek.vasut@gmail.com> Marek Vasut wrote:
> 
> Me and a coleague of mine recently ran into the issue [1]. The problem is, that 
> I set mmap_min_addr to 65536, making it unable for "su - user" command to work, 
> it crashes with SIGKILL. I now at least see a solution (set it to 32768). Though 
> I don't understand why. Can someone please exaplain me why it has to be 32768 an 
> not more?
> 
> [1] http://ubuntu.5.n6.nabble.com/PATCH-DEFAULT-MMAP-MIN-ADDR-32768-for-arm-td1604723.html


It appears the problem was introduced with commit cde7c41 "ARM:
configs: add defconfig for mach-mxs" which sets the default for
CONFIG_DEFAULT_MMAP_MIN_ADDR for MXS systems to 64 k.

"security/Kconfig" has somewhat related documentation:

	config LSM_MMAP_MIN_ADDR
	...
		default 32768 if ARM
		default 65536
		...
		On arm and other archs it should not be higher than 32768.

The reason is that on ARM the text segment of applications gets mapped
to 32 k, which fails for non-root processes if MMAP_MIN_ADDR is higher.


Is there any specific reason why you set it to 64 k for MXS ?

Can you please check if non-root processes work for you with this
configuration?

Thanks.

Wolfgang Denk

-- 
DENX Software Engineering GmbH,     MD: Wolfgang Denk & Detlev Zundel
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd at denx.de
I used to be indecisive, now I'm not sure.
