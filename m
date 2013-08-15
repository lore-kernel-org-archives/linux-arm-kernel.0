From: 21cnbao@gmail.com (Barry Song)
Date: Thu, 15 Aug 2013 11:44:30 +0800
Subject: [ARM ATTEND] Trustzone-based security solution for ARM Linux
Message-ID: <CAGsJ_4xnivwNW_Pvhv7Jg62a94d5FChwqEwnNX3Miqd5fAxNHA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

For the moment, there is strong markting requirement from
IVI(In-Vehicle Infotainment) or mobile to use ARM Trustzone. We take
IVI as an example, Auto requires security enviorment to access CAN bus
and other car busses. Auto requires security enviorment to show
rearview/surround view from cameras and play alert audio. on the other
hand, IVI system is generically working as a video streaming sink and
HDMI sink instead of a source. To support HDCP and widevine, we need
to make sure private keys and video buffers are only visible to
security mode. With CAN stack, video playback backend and more tasks,
generically it requires a multi-task RTOS running in security mode
parallel with Linux in non-security mode.

Linux is a generic purpose OS with UI and all kinds of software, but
we need to make sure even the Linux is ROOTed, RTOS in security mode
is still active. We are able to find some opensource projects like
SafeG[1], Multivisor[2], SierraVisor[3], but it turns out that ARM
Linux has no rich support for this kind of architecture:
1. hypervisor running in monitor mode
2. RTOS running in security mode
3. Linux running in non-security mode

So the point is that we need generic support for this, especially for
IVI and other markets which want Trustzone technology a lot and have
complex user scenarios.
1. Dispatch FIQ to security, dispatch IRQ to Linux, for this case, FIQ
is not permitted to happen on Linux
2. IPC support for communication between RTOS in security mode and
Linux in non-security mode, as we need to communicate rich commands
and buffers
3. as some CPU time is stolen by security mode, so the scheduler need
to get this for load balance

For IPC, RPMsg is kind of popular for commucating cross HMP. For
example, OMAP uses it as the IPC between M3 and A9; XilinX uses it as
IPC between two A9, one with FreeRTOS, the other one with Linux; ST-E
uses it to connect ARM with modem MCU. So we are also considering the
possibility to involve RPMsg as the backend for communication between
RTOS in security mode and Linux in non-security mode. then we get much
benefit from virtio, and some drivers will be usable directly.

So for this topic, I want a presentation session with about 5 slides
to show the high-level architecture and requirement for a real and
complex Trustzone user case. Hoping we can get some rich support from
Linux for this architecture.

On the other hand, if people can discuss Android mainlining project
more, i like much. for the moment, most Android patches have been
mainlined, but we still need to maintain both branches as there are
rebased patches from Google. So i want to get input about best
pratice.

[1]SafeG (Safety Gate):
http://www.toppers.jp/en/safeg.html
[2]Green Hills Multivisor:
http://www.ghs.com/products/rtos/integrity_virtualization.html
[3]SierraVisor:
http://www.openvirtualization.org/

-barry
