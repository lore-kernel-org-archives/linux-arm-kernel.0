From: mark.rutland@arm.com (Mark Rutland)
Date: Thu, 28 Apr 2016 10:29:34 +0100
Subject: [PATCH v6 2/2] memory: atmel-ebi: add DT bindings documentation
In-Reply-To: <20160428084405.4d71efbc@bbrezillon>
References: <1461767754-12189-1-git-send-email-boris.brezillon@free-electrons.com>
 <1461767754-12189-3-git-send-email-boris.brezillon@free-electrons.com>
 <20160427150738.GA7359@leverpostej>
 <20160428084405.4d71efbc@bbrezillon>
Message-ID: <20160428092843.GA21145@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Thu, Apr 28, 2016 at 08:44:05AM +0200, Boris Brezillon wrote:
> On Wed, 27 Apr 2016 16:07:38 +0100
> Mark Rutland <mark.rutland@arm.com> wrote:
> > On Wed, Apr 27, 2016 at 04:35:54PM +0200, Boris Brezillon wrote:
> > > +	ebi: ebi at 10000000 {
> > > +		compatible = "atmel,sama5d3-ebi", "simple-bus";  
> > > +		#address-cells = <2>;
> > > +		#size-cells = <1>;
> > > +		atmel,smc = <&hsmc>;
> > > +		atmel,matrix = <&matrix>;
> > > +		reg = <0x10000000 0x10000000
> > > +		       0x40000000 0x30000000>;
> > > +		ranges = <0x0 0x0 0x10000000 0x10000000
> > > +			  0x1 0x0 0x40000000 0x10000000
> > > +			  0x2 0x0 0x50000000 0x10000000
> > > +			  0x3 0x0 0x60000000 0x10000000>;
> > > +		clocks = <&mck>;
> > > +
> > > +		pinctrl-names = "default";
> > > +		pinctrl-0 = <&pinctrl_ebi_addr>;
> > > +
> > > +		cs at 0 {  
> > > +			#address-cells = <2>;
> > > +			#size-cells = <1>;
> > > +			ranges;
> > > +			atmel,generic-dev;  
> > > +			atmel,read-mode = "nrd";
> > > +			atmel,write-mode = "nwe";
> > > +			atmel,bus-width = <16>;
> > > +			atmel,ncs-rd-setup-ns = <0>;
> > > +			atmel,ncs-wr-setup-ns = <0>;
> > > +			atmel,nwe-setup-ns = <8>;
> > > +			atmel,nrd-setup-ns = <16>;
> > > +			atmel,ncs-rd-pulse-ns = <84>;
> > > +			atmel,ncs-wr-pulse-ns = <84>;
> > > +			atmel,nrd-pulse-ns = <76>;
> > > +			atmel,nwe-pulse-ns = <76>;
> > > +			atmel,nrd-cycle-ns = <107>;
> > > +			atmel,nwe-cycle-ns = <84>;
> > > +			atmel,tdf-ns = <16>;
> > > +
> > > +			nor: flash at 0,0 {
> > > +				compatible = "cfi-flash";
> > > +				#address-cells = <1>;
> > > +				#size-cells = <1>;
> > > +				reg = <0x0 0x0 0x1000000>;  
> > 
> > It feels odd that in the node for chipselect N, sub-devices have to
> > encode the chipselect number in their reg, when it's obvious from their
> > container. It may make more sense for the cs node to have a non-empty
> > reg (or somehow to make that translation/truncation implicit).
> 
> Would you agree with the following representation?
> 
> 	ebi: ebi at 10000000 {
> 		compatible = "atmel,sama5d3-ebi";
> 		#address-cells = <2>;
> 		#size-cells = <1>;
> 		atmel,smc = <&hsmc>;
> 		atmel,matrix = <&matrix>;
> 		reg = <0x10000000 0x10000000
> 		       0x40000000 0x30000000>;
> 		ranges = <0x0 0x0 0x10000000 0x10000000
> 			  0x1 0x0 0x40000000 0x10000000
> 			  0x2 0x0 0x50000000 0x10000000
> 			  0x3 0x0 0x60000000 0x10000000>;
> 		clocks = <&mck>;
> 
> 		pinctrl-names = "default";
> 		pinctrl-0 = <&pinctrl_ebi_addr>;
> 
> 		configs {
> 			config-0 {
> 				atmel,read-mode = "nrd";
> 				atmel,write-mode = "nwe";
> 				atmel,bus-width = <16>;
> 				atmel,ncs-rd-setup-ns = <0>;
> 				atmel,ncs-wr-setup-ns = <0>;
> 				atmel,nwe-setup-ns = <8>;
> 				atmel,nrd-setup-ns = <16>;
> 				atmel,ncs-rd-pulse-ns = <84>;
> 				atmel,ncs-wr-pulse-ns = <84>;
> 				atmel,nrd-pulse-ns = <76>;
> 				atmel,nwe-pulse-ns = <76>;
> 				atmel,nrd-cycle-ns = <107>;
> 				atmel,nwe-cycle-ns = <84>;
> 				atmel,tdf-ns = <16>;
> 			};
> 		};
> 
> 		nor: flash at 0,0 {
> 			compatible = "cfi-flash";
> 			#address-cells = <1>;
> 			#size-cells = <1>;
> 			reg = <0x0 0x0 0x1000000>;
> 			bank-width = <2>;
> 		};
> 	};

Something of that sort looks good to me, yes.

Thanks,
Mark.
