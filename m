From: starnight@g.ncu.edu.tw (Jian-Hong Pan)
Date: Fri, 24 Aug 2018 01:15:40 +0800
Subject: [RFC 0/3 net] lorawan: Add LoRaWAN soft MAC module
Message-ID: <cover.1535039998.git.starnight@g.ncu.edu.tw>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

LoRaWAN(TM) is the MAC layer defined by LoRa Alliance(TM) over LoRa
devices.  LoRa is one of Low-Power Wide-Area Network (LPWAN) technology.

LoRaWAN networks typically are laid out in a star-of-stars topology in
which gateways relay messages between end-devices and a central network
server at the backend.  Gateways are connected to the network server via
standard IP connections while end-devices use single hop LoRa(TM) or FSK
communication to one or many gateways.

A LoRa network distinguishes between a basic LoRaWAN (named Class A) and
optional features (Class B, Class C ...):
* Bi-directional end-devices (Class A)
* Bi-directional end-devices with scheduled receive slots (Class B)
* Bi-directional end-devices with maximal receive slots (Class C)

This patch set add LoRaWAN class module implementing the stack,
especially the soft MAC, between socket APIs and LoRa device drivers.

socket APIs:
send and receive the data
------------------------------------------------------------------------
LoRaWAN class module implements soft MAC:
append the header/footer, encryption/decryption, timing slot and MAC
commands
------------------------------------------------------------------------
LoRa device drivers:
send and receive the messages for MAC layer
------------------------------------------------------------------------
LoRa devices

This module starts from simple and implements partial Class A
end-devices features defined in LoRaWAN(TM) Specification Ver. 1.0.2.
More features and complexity, for example regional parameters, confirmed
data messages, join request/accept messages for Over-The-Air Activation,
MAC commands ... will be added in the future.

Besides, I upload these patches and open discussion.  For example, the
more common/flexible interface for compatible LoRa device drivers and
protocols implementation, etc.

Another idea mentioned by Andreas: Make PF_LORA and PF_LORAWAN like
PF_INET and PF_INET6 exist at the same time.  That is also interesting.

Jian-Hong Pan (3):
  lorawan: Add LoRaWAN class module
  lorawan: Add macro and definition for LoRaWAN class modlue
  lorawan: List LORAWAN in menuconfig

 include/linux/maclorawan/lora.h     | 239 ++++++++++
 include/linux/socket.h              |   5 +-
 include/uapi/linux/if_arp.h         |   1 +
 include/uapi/linux/if_ether.h       |   1 +
 net/Kconfig                         |   1 +
 net/Makefile                        |   1 +
 net/core/dev.c                      |   4 +-
 net/maclorawan/Kconfig              |  14 +
 net/maclorawan/Makefile             |   2 +
 net/maclorawan/lorawan.h            | 219 +++++++++
 net/maclorawan/lrwsec.c             | 237 ++++++++++
 net/maclorawan/lrwsec.h             |  57 +++
 net/maclorawan/mac.c                | 552 ++++++++++++++++++++++
 net/maclorawan/main.c               | 665 ++++++++++++++++++++++++++
 net/maclorawan/socket.c             | 700 ++++++++++++++++++++++++++++
 security/selinux/hooks.c            |   4 +-
 security/selinux/include/classmap.h |   4 +-
 17 files changed, 2701 insertions(+), 5 deletions(-)
 create mode 100644 include/linux/maclorawan/lora.h
 create mode 100644 net/maclorawan/Kconfig
 create mode 100644 net/maclorawan/Makefile
 create mode 100644 net/maclorawan/lorawan.h
 create mode 100644 net/maclorawan/lrwsec.c
 create mode 100644 net/maclorawan/lrwsec.h
 create mode 100644 net/maclorawan/mac.c
 create mode 100644 net/maclorawan/main.c
 create mode 100644 net/maclorawan/socket.c

-- 
2.18.0
