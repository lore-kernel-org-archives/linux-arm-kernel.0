From: nico@fluxnic.net (Nicolas Pitre)
Date: Fri, 08 Apr 2011 09:19:38 -0400 (EDT)
Subject: [PATCH 1/2] arm: Replace CONFIG_HAS_TLS_REG with HWCAP_TLS and
	check for it on V6
In-Reply-To: <BANLkTim4TTf3KXGYzjcvQ2n-hNbdSQM1eg@mail.gmail.com>
References: <20100623133636.GC7058@shareable.org>
	<20100629141836.GM2822@atomide.com>
	<alpine.LFD.2.00.1006291355520.24097@xanadu.home>
	<20100630110828.GZ2822@atomide.com> <20100630131737.GF2822@atomide.com>
	<alpine.LFD.2.00.1006301011520.24097@xanadu.home>
	<20100701092510.GH2822@atomide.com>
	<20100701174051.GA8786@shareable.org>
	<alpine.LFD.2.00.1007012226170.26524@xanadu.home>
	<20100702103744.GJ6632@atomide.com>
	<20100705135526.GF15951@atomide.com>
	<BANLkTim4TTf3KXGYzjcvQ2n-hNbdSQM1eg@mail.gmail.com>
Message-ID: <alpine.LFD.2.00.1104080911520.28032@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 8 Apr 2011, Li Li wrote:

> Dears,
> 
> I cannot understand how TLS EMU ensure it's SMP safe, because get_tls
> helper (at 0xffff0fe0) just read the value from 0xffff0ff0. But all
> SMP cores should have the exact same mapping to the vectors page (at
> 0xffff0000). So various threads running on different SMP cores at the
> same time would get the same emulated TLS value (instead of thread
> specific value set via set_tls). Could anybody explain this a little
> bit?

On SMP the hardware TLS register is always available, therefore the TLS 
value is not stored at 0xffff0ff0.  The code actually installed at 
0xffff0fe0 is modified at boot time by kuser_get_tls_init to select 
either the ldr or the mrc instruction to retrieve the TLS value.


Nicolas
