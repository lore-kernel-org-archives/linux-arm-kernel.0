From: s-ghorai@ti.com (Ghorai, Sukumar)
Date: Sat, 19 Sep 2009 17:52:23 +0530
Subject: [PATCH  RFC] MMC card of Size > 4GB support in Linu
Message-ID: <2A3DCF3DA181AD40BDE86A3150B27B6B02F64D8199@dbde02.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Pierre & all,

This is the email continuing the discussion about the 4GB MMC card support in Linux MMC/SD driver. Note that the discussion is for MMC card only, not for SD card.

There are two register as below are used to check the card capability including size of the Card.

1. The Card-Specific Data (CSD) register defines the data format, error correction type, maximum data access time, data transfer speed etc. used for how to access the card contents.

2.  And Extended CSD register (EXT_CSD: 512 bytes long) defines the card capabilities and cannot be modified by the host.
    This EXT_CSD is supported by MMC card only (not for SD).

I). How to check the card Size?
The Card size (C_SIZE) in CSD register used to compute the card capacity. And the maximal capacity which can be coded is 4 GBytes. But higher than 2GB of density of card the maximum possible value should be set to this register (0xFFF). 

II). How to check whether is card is >=4GBytes size?
We could check in access mode from OCR register and/or read the EXT_CSD register.  Check the SEC_COUNT filed in EXT_CSD register.
The device density is calculated from the value of SEC_COUNT and multiplying by 512B/sector. The maximum density possible to be indicated is thus 2 Tera bytes.

III). So we need to check / validate the response from card for CSD and EXT_CSD register.
Two of the fields in CSD Structure Version (CSD_STRUCTURE) and Extended CSD Revision (EXT_CSD_REV) and the details of the bit filed as follows. 
i.e. CSD_STRUCTURE should be >= 2 support card more than 4GB and EXT_CSD_REV should be <3; 

CSD_STRUCTURE| CSD structure version| Valid for System Specification Ver
------------------------------------------------------------------------
        0    | CSD version No. 1.0  | Version 1.0 - 1.2
        1    | CSD version No. 1.1  | Version 1.4 - 2.2
        2    | CSD version No. 1.2  | Version 3.1 - 3.2-3.31 - 4.0-4.1-4.2
      3-255  | Reserved for future use

EXT_CSD_REV  | Extended CSD Revision
-------------------------------------
       255-3 | Reserved 
           2 | Revision 1.2 
           1 | Revision 1.1 
           0 | Revision 1.0

IV). And what I understood from MMCA specification is that - 
EXT_CSD[EXT_CSD_REV]: Defines the fixed parameters and related to the EXT_CSD register, according to its revision. And it's nothing to do with MMCA specification version or to support > 4GB card.

V). But in current Linux MMC code it's expecting EXT_CSD_REV should be >=2; 
And if any card of size >= 4GB and EXT_CSD_REV field value is <2, 
And MMC card won't work.

I have seen cards which having EXT_CSD_REV is <2 and working in other OS.
So, Here I am sending the possible solution. `

----------------------------------------------------------------------------
