From: helmut@helios.de (Helmut Tschemernjak)
Date: Thu, 5 Jul 2018 12:43:36 +0200
Subject: [RFC net-next 00/15] net: A socket API for LoRa
In-Reply-To: <487df785-ddf5-ed81-a253-6afb7f2de811@datenfreihafen.org>
References: <20180701110804.32415-1-afaerber@suse.de>
 <487df785-ddf5-ed81-a253-6afb7f2de811@datenfreihafen.org>
Message-ID: <5aac9ea5-484c-1b3b-8058-50e11e8d7a9a@helios.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Andreas,

I put the kernel support for the SX1276 LoRa chip in question. I don?t 
think that this kind of device should be in the Linux kernel.

Here are a few facts to consider:
- A LoRa transaction is very slow? (e.g. SF7 needs about 210 ms, for 
SF12 6280 ms) for 12 bytes user data with acknowledge.

- There are many different implementations for the antenna switch, 
switching between receiving/sending, PA-BOOST, 433, 868/915 MHz. (I know 
SX1276 Heltec ESP32, SX1276 Murata, RFM95-(1276), SX1276 Heltec 
STM32-L4) they are all different regarding this.

- The LoRa chip device ID is only 8-bit which is not sufficient for 
larger networks, e.g. our RadioShuttle protocol uses compressed 32-bit 
device IDs.

- The chip can do MTU sizes up to 2048 bytes, most protocols use less 
than 250 bytes.

- Applications do on-the-fly channel and spreading factor switching 
which makes it more difficult for the configuration.

- The chip supports Lora modulation as well as? FSK, GFSK, MSK, GMSK, 
and OOK modulation, for some use cases the other modulations are of 
interest, e.g. to communicated with other devices.

- Power saving modes, like sleep, suspend may be required for battery 
operation.

- Cad detection is very flexible and can be differently used.

- LoRa preamble may be different depending on the protocol used.

- The new Lora chip SX1262 / 68 (successor of the SX1276) has different 
hardware and all different registers, it is driver incompatible with the 
SX1276. It needs an entire new driver.

- The device is not multi-process capable (only a single process can 
communicate with it).

- There are SX1276 LoRa modules with a build-in protocol (LoRaWAN and 
RAW) via a serial connection only, again complete different API compared 
the SX1276 chip. Software updates for this devices are difficult.

- I am even convinced that the LoRaWAN protocol with the concentrator 
concept is not good, the peer to peer communication and a standard MQTT 
gateway (what we do) is way more flexible.

For all this reasons, I feel a user level driver task implementation is 
way more flexible. I did a lot of work/enhancements on the SX1276 link 
level driver from Semtech, it is available and maintained on mbed.org 
and supports mbed-os, Arduino and is prepared for Linux.
https://os.mbed.com/users/Helmut64/code/SX1276GenericLib/

Protocols e.g. our RadioShuttle LoRa peer to peer protocol or the 
LoRaWAN protocol can run on top of the SX1276GenericLib. We may should 
focus on such a driver library getting supported for multiple OS's (Win, 
Linux, mbed, Ardino, etc.)

Again I feel a Linux kernel device driver for the SX1276 chip make 
little sense for me.

Regards
Helmut Tschemernjak (www.radioshuttle.de, www.helios.de)
