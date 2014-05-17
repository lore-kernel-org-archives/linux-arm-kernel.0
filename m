From: tomasz.figa@gmail.com (Tomasz Figa)
Date: Sat, 17 May 2014 14:16:52 +0200
Subject: [RFC PATCH 1/9] dt: deps: dtc: Automatically add new property
 'dependencies' which contains a list of referenced phandles
In-Reply-To: <1399913280-6915-2-git-send-email-holler@ahsoftware.de>
References: <1399913280-6915-1-git-send-email-holler@ahsoftware.de>
 <1399913280-6915-2-git-send-email-holler@ahsoftware.de>
Message-ID: <53775334.3030704@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Alexander,

On 12.05.2014 18:47, Alexander Holler wrote:
> During the step from .dts to .dtb the information about dependcies contained
> in the .dts through phandle references is lost. This makes it impossible to
> use the binary blob to create a dependency graph without knowing the semantic
> of all cell arrays.
> 
> Therefor automatically add a new property called 'dependencies' to all nodes
> which have phandle references in one of their properties.
> 
> This new property will contain an array of phandles with one value for every
> phandle referenced by other properties in the node.
> 
> If such a property already exists (e.g. to manually add dependencies through
> the .dts), the existing list will be expanded.
> 
> Added phandles will be the phandle of either the referenced node itself (if
> it has a property named 'compatible', or of the next parent of the referenced
> node which as property named 'compatible'. This ensures only dependencies to
> drivers will be added.
> 

Sounds good.

> References to phandles of parent or child nodes will not be added to this
> property, because this information is already contained in the blob (in the
> form of the tree itself).

I wonder if we shouldn't be including them too for consistency related
reasons, so we have all the necessary information in one place.
References to child nodes are great recipes for cycles, though...

No strong opinion, though, just an idea.

> 
> No dependencies to disabled nodes will be added.
> 

Same here. IMHO it might be wise to let the parsing entity (e.g. kernel)
decide whether to ignore a dependency to disabled node or not.

Otherwise, I like the simplicity of compile-time dependency list
creation. Quite a nice work.

Best regards,
Tomasz
