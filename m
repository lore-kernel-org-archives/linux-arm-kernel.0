From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 18 Mar 2016 15:18:26 +0000
Subject: [PATCH] ARM: configs: Enabling the new Marvell's cryptographic
 engine driver for mvebu_v7_defconfig
In-Reply-To: <20160318143059.GD8005@lunn.ch>
References: <20160318081209.GA7394@archy.home> <20160318131432.GB8005@lunn.ch>
 <20160318145131.76ffa0e1@free-electrons.com>
 <20160318143059.GD8005@lunn.ch>
Message-ID: <20160318151826.GI19428@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Mar 18, 2016 at 03:30:59PM +0100, Andrew Lunn wrote:
> On Fri, Mar 18, 2016 at 02:51:31PM +0100, Thomas Petazzoni wrote:
> > Hello,
> > 
> > On Fri, 18 Mar 2016 14:14:32 +0100, Andrew Lunn wrote:
> > 
> > > Isn't this also applicable to mvebu v5?
> > > 
> > > And your change to multi_v7_defconfig could also be applied to
> > > multi_v5_defconfig.
> > 
> > mvebu_v5 already enables a crypto driver, but it's the old one. So
> > there's a decision to be taken here whether we move all the platforms
> > to use the new driver or not.
> > 
> > The new driver has been tested on the Armada family, and I believe also
> > on Kirkwood. However I'm pretty sure it hasn't been tested on Dove and
> > Orion.
> 
> I don't know crypto to well. Is there a good test case? Something
> simple to setup and run. I can test on kirkwood and Dove using the
> hardware i have.

That's kind of the sticking point for userspace.  As I understand the
situation, there's been two userspace APIs for crypto - the current
one, which is network based (af-alg-rr), but performs badly, and
another (I forget what it's called but it needs kernel patches, but
is more popular amongst openwrt folk) which I've no experience of.

There's an openssl plugin to talk to the kernel crypto drivers via
this AF_ALG interface, but you have to hunt around for it and build
it.  Once built and installed, it needs a bit of configuration:

Towards the top of openssl.cnf:

openssl_conf           = openssl_def

[openssl_def]
engines                 = engine_section

and further down:

[engine_section]
af_alg = af_alg_engine

[af_alg_engine]
# Armada 388:
#  cbc(des):des-cbc
#  ecb(aes):des-ecb*
#  cbc(des3_ede):des-ede3-cbc
#  ecb(des3_ede):des-ede3-ecb
#  cbc(des):aes-128-cbc aes-192-cbc aes-256-cbc
#  ecb(des):aes-128-ecb aes-192-ecb aes-256-ecb
#CIPHERS=aes-128-cbc aes-192-cbc aes-256-cbc des-cbc des-ede3-cbc

# Armada 388 and Dove can only do md5, sha1 and sha256 in hardware
DIGESTS=md5 sha256 sha1

# Putting this last means we register the above as the default algorithms
#default_algorithms     = ALL

I'd suggest for testing purposes, not to put this into the system
openssl.cnf, but create a copy of that and add the above to that copy.
Then, run openssl using:

OPENSSL_CONF=/path/to/my/openssl.cnf openssl dgst -md5 FILE

and compare the output with md5sum etc.  strace will confirm whether
openssl is using the AF_ALG interface (you shoudl see it send()ing the
data to an accept()'d AF_ALG socket.)

-- 
RMK's Patch system: http://www.arm.linux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
