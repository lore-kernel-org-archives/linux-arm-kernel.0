From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Fri, 6 Jan 2017 13:07:27 +0000
Subject: [PATCHv2 net-next 09/11] net: mvpp2: simplify MVPP2_PRS_RI_*
 definitions
In-Reply-To: <1482943567-12483-10-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1482943567-12483-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1482943567-12483-10-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <20170106130727.GB14217@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Dec 28, 2016 at 05:46:05PM +0100, Thomas Petazzoni wrote:
> Some of the MVPP2_PRS_RI_* definitions use the ~(value) syntax, which
> doesn't compile nicely on 64-bit. Moreover, those definitions are in
> fact unneeded, since they are always used in combination with a bit
> mask that ensures only the appropriate bits are modified.
> 
> Therefore, such definitions should just be set to 0x0. For example:
> 
>  #define MVPP2_PRS_RI_L2_CAST_MASK              0x600
>  #define MVPP2_PRS_RI_L2_UCAST                  ~(BIT(9) | BIT(10))
>  #define MVPP2_PRS_RI_L2_MCAST                  BIT(9)
>  #define MVPP2_PRS_RI_L2_BCAST                  BIT(10)
> 
> becomes
> 
>  #define MVPP2_PRS_RI_L2_CAST_MASK              0x600
>  #define MVPP2_PRS_RI_L2_UCAST                  0x0
>  #define MVPP2_PRS_RI_L2_MCAST                  BIT(9)
>  #define MVPP2_PRS_RI_L2_BCAST                  BIT(10)

So this is a two-bit field in a register with three defined states - I'm
not sure that using BIT() here is really a good idea.  BIT() is fine for
single-bit controls, but I think it adds an additional level of confusion
for multi-bit controls.

Also, the combination of the mask being defined as hex and the controls
using BIT() is particularly not nice.  I think either use one style or
the other, don't mix them.  So either:

  #define MVPP2_PRS_RI_L2_CAST_MASK              0x600
  #define MVPP2_PRS_RI_L2_UCAST                  0x000
  #define MVPP2_PRS_RI_L2_MCAST                  0x200
  #define MVPP2_PRS_RI_L2_BCAST                  0x400

or:

  #define MVPP2_PRS_RI_L2_CAST_MASK              (BIT(10) | BIT(9))
  #define MVPP2_PRS_RI_L2_UCAST                  0
  #define MVPP2_PRS_RI_L2_MCAST                  BIT(9)
  #define MVPP2_PRS_RI_L2_BCAST                  BIT(10)

It then becomes obvious that the mask and the settings are changing the
same bits.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
