From: benh@kernel.crashing.org (Benjamin Herrenschmidt)
Date: Sat, 29 Aug 2015 20:37:11 +1000
Subject: [PATCH v5 2/4] Documentation: arm64/arm: dt bindings for numa.
In-Reply-To: <55E17F58.5020101@huawei.com>
References: <1439570374-4079-1-git-send-email-gkulkarni@caviumnetworks.com>
 <1439570374-4079-3-git-send-email-gkulkarni@caviumnetworks.com>
 <20150828123228.GE31748@leverpostej>
 <CAL_JsqLOpUTVeKbkJ6uPi0EYistd=BowAHdtSmaUYYDhU6c9Sg@mail.gmail.com>
 <55E17F58.5020101@huawei.com>
Message-ID: <1440844631.2912.248.camel@kernel.crashing.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, 2015-08-29 at 17:46 +0800, Leizhen (ThunderTown) wrote:
> Why not copy the method of ACPI numa? There only three elements
> should be configured:
> 1) a cpu belong to which node
> 2) a memory block belong to which node
> 3) the distance of each two nodes

This means your are bolting into the DT representation the concept of
"Node" which isn't necessarily very meaningful.

Your system is really a hierarchy of objects. You can have cores on a
chip, already possibly sharing some level of cache or not, you can have
chips on a module, modules linked at various distances, etc...

What is "a node" ?

For example, I have a P8 chip with 2 chips on a module (fast X-bus) and
2 modules (slightly slower A-bus). All 4 chips have 2 memory
controllers each.

Is a "node" a chip or a module ?

The Linux concept of node is too restrictive. The associativity
properties avoid this by allowing you to define as many "levels" of
associativity as you wish. Also since it's right justified, a given
component doesn't need to have all levels (a MC can stop at chip while
cores can go down one more level for example).

The reference points property gives a hint as "interesting" levels can
typically be used as a hint for chosing what Linux will use as a "node"
at least until Linux gets smarter. It can also be used to calculate
distances.

Cheers,
Ben.
