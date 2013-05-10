From: srinivas.kandagatla@st.com (Srinivas KANDAGATLA)
Date: Fri, 10 May 2013 13:51:14 +0100
Subject: [RFC 3/8] mfd:syscon: Introduce claim/read/write/release APIs
In-Reply-To: <20130509095143.GB7478@sirena.org.uk>
References: <1368022187-1633-1-git-send-email-srinivas.kandagatla@st.com>
 <1368022272-2241-1-git-send-email-srinivas.kandagatla@st.com>
 <201305081650.23264.arnd@arndb.de>
 <20130508150141.GA5057@opensource.wolfsonmicro.com> <518A8E6C.6070907@st.com>
 <20130509095143.GB7478@sirena.org.uk>
Message-ID: <518CED42.7010700@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Marc,

I would like to explain you bit more about "ST System Configuration
registers".

The SOCs are assembled from existing IP blocks, which don't change very
often. However these blocks are assembled in different configurations to
meet the device requirements. So most IP blocks as well as having a bus
interface through which their own registers are accessible, will also
have a number of bristles(wires) which are signals that are going in and
out of the IP for configuration and status. To make these signals
accessible to software they are wired to "System Configuration Registers".

Drivers target the IP blocks, which don't change much. Where as the
mapping of IP specific bristles(wires) to "System Configuration
Registers" do change per each SOC, and therefore we do not want this
information to be part of the driver.

Having a System Configuration infrastructure gives much flexibility and
abstraction to drivers to configure them.

Given the comments on the patch, I am inclined not to use syscon for ST
specific "System Configuration Registers", alternatively I would like to
create a separate mfd system configuration driver specific to ST.

This is how we did it initially in the out-of-tree kernel.
http://git.stlinux.com/?p=stm/linux-stm.git;a=blob;f=drivers/stm/sysconf.c

Any suggestions?


thanks,
srini

On 09/05/13 10:51, Mark Brown wrote:
> On Wed, May 08, 2013 at 06:42:04PM +0100, Srinivas KANDAGATLA wrote:
> 
> Fix your mailer to word wrap within paragraphs.
> 
>> Ultimately the syscon_write use the regmap_update_bits, however we
>> really want is the flexibility in using/referring the syscon
>> registers/bits in both device-trees and non-device tree cases.
> 
> So what you're looking for here is some way to offload discovery of
> register fields from the driver?
> 
>> The reason for these APIs, is the extent of syscon usage is very high
>> in ST set-top-box parts.
> 
>> Without these new APIs, its very difficult to pass this information to
>> the drivers.
> 
> I'm not 100% convinced that putting all this information into DT is a
> good idea, and to the extent that it is sensible it feels like something
> which might be useful with any device using register maps, not just
> syscon.  For example many MFDs have similar needs - essentially the
> system controllers are just a particular kind of MFD.  To me that says
> that this should be outside syscon so other things can use it.
> 
