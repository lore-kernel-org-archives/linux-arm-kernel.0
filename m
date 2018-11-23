From: broonie@kernel.org (Mark Brown)
Date: Fri, 23 Nov 2018 13:44:11 +0000
Subject: [PATCH 3/3] regulator: mcp16502: add regulator driver for MCP16502
In-Reply-To: <03b902d9-49a8-9acd-6f98-048f117b1e93@microchip.com>
References: <1542108563-10108-1-git-send-email-andrei.stefanescu@microchip.com>
 <1542108563-10108-4-git-send-email-andrei.stefanescu@microchip.com>
 <20181113174539.GB2089@sirena.org.uk>
 <03b902d9-49a8-9acd-6f98-048f117b1e93@microchip.com>
Message-ID: <20181123134411.GG2089@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 21, 2018 at 03:44:31PM +0000, Andrei.Stefanescu at microchip.com wrote:

> Thank you for your review. While working on the next version I realized that
> the implementation should change a bit. The mcp16502 PMIC has separate 
> registers
> for each of its operating modes (Performance, Active, Low-power, Hibernate).
> So, it is possible to setup the values for Low-power (Linux standby) and
> Hibernate (Linux suspend-to-ram) and these values would not be affected by
> changes made during runtime (which are made to the ACTIVE registers).

This is totally normal for regulators, it's the only way that suspend
modes can function sensibly since suspend mode configuration is
typically not capable off supplying the processor.  If your driver is
currently trying to use the normal operating registers then it's buggy.

> This means that the calls to suspend_set_* are not necessary to be made each
> time the board suspends. My idea is to add three functions to the 
> regulator_ops
> (setup_suspend_standby/mem/max) which would be called after the regulator is
> registered and which would set the values found inside the devicetree
> in the regulator-state-standby/mem/disk subnodes.

There is no need to add new operations, we already have a number of
suspend specific operations covering enable state, modes and voltage.
You should just use those, there's already code to call them.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 488 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20181123/f7dcec59/attachment-0001.sig>
