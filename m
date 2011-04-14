From: zajec5@gmail.com (=?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?=)
Date: Thu, 14 Apr 2011 13:28:10 +0200
Subject: Could I (ab)use bus (struct bus_type) for virtual Broadcom bus?
Message-ID: <BANLkTim7Uj2tsgFngWhUqFK_hk3Leg+sQA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

We have slightly improved our knowledge of new Broadcom's bus. It
appears Broadcom took standard AMBA bus and put on it two cores for
every device:
1) First core from each pair is real AMBA device, it has CID and PID.
Broadcom called it wrapper, it is used to control second core
(enabling second, disabling second, resetting second, setting flags of
second).
2) Second core from each pair is Broadcom specific device. It can
*not* be treated as standard AMBA core - attempting to read it's CID
on PID leads to machine hang. Instead it is identified by MANUF, ID,
REV and CLASS. Example can be 80211 core.

One of the idea is to integrate with current AMBA driver:
1) First driver read info about all cores in Broadcom specific way. It
registers all *wrapper* (AMBA type) cores as amba_device(s).
2) Second driver registers for cores with PID 0x103BB369 (Broadcom
specific I believe). It receives wrappers (from AMBA bus) and exposes
wrapper-related Broadcom specific core in the system.

Problem: how to expose Broadcom specific cores in the system? Remember
we can not use amba_device, because Broadcom specific cores are
programmed and identified differently.

Could we register some virtual bcm_amba bus in the system and register
Broadcom specific cores with it? Or is there something better for this
case? In summary everything I need is to make driver (for example b43)
able to register for Broadcom specific core with Broadcom specific
identifiers. For example:
static const struct axi_device_id b43_axi_tbl[] = {
	AXI_CORE(AXI_MANUF_BCM, AXI_CORE_80211, 0x17, AXI_ANY_CLASS),
	AXI_CORETABLE_END
};
MODULE_DEVICE_TABLE(axi, b43_axi_tbl);

We have problems deciding architecture, the whole proposed layout is
not approved as final yet. Right now I try to check possibilities.

-- 
Rafa?
