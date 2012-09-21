From: swarren@wwwdotorg.org (Stephen Warren)
Date: Thu, 20 Sep 2012 22:22:05 -0600
Subject: bcm2835: property mailbox or dedicated mailbox for upstream?
Message-ID: <505BEB6D.2040200@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

As background for those not familiar with the BCM2835 SoC, many aspects
of the HW are controlled by firmware running on the VideoCore processor
that exists alongside the ARM CPU, and communication to that core is via
a "mailbox" interface, with SW-defined/implemented messages. The mailbox
interface defines so-called channels, and on each channel a certain
format of messages and protocol is expected.

For some message types, there are different protocols that may be used.
For example, both power management, framebuffer messages may be sent on
the older dedicated channels (0, 1 respectively) or using a more
extensible format on the "property" channel (8/9).

I'd like to propose that for the upstream kernel, we exclusively use the
new property mailbox for the features it supports. In general, the
messages implemented via this protocol are much more flexible and/or
complete than those implemented on the older dedicated channels.

For example, for power management, each message deals with a single HW
module at a time (SD, USB, etc.). This allows each regulator driver on
the Linux side to be coded completely independently. However, the older
dedicated channel requires a bitmask that defines the state of all HW
modules at once, which requires code to unify all the regulator states
together when sending messages, which make the Linux driver more complex.

This of course would make the upstream kernel non-compatible with older
firmwares. But, updating firmware is trivial (copy a file to your SD
card), so this doesn't seem like too big of an issue.

Does anyone disagree with this, or have any other comments?

BTW, are the message formats (for those messages which are defined)
considered stable now; all future changes will be made in a
backwards-compatible fashion?

Perhaps it would be useful to define a new message for "get protocol
version" which would indicate major (incompatible version) and minor
(compatible extensions such as new messages available, or extending
existing messages with more data). Or, should this be inferred from the
existing "get firmware version" message?
